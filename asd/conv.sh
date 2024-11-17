#!/bin/bash

set -uo pipefail
IFS=$'\n\t'

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

readonly PROGRAM_NAME=$(basename "$0")

readonly SUPPORTED_IMAGE_FORMATS="jpg|jpeg|png|gif|bmp|tiff|webp"
readonly SUPPORTED_VIDEO_FORMATS="mp4|avi|mkv|mov|webm|flv|wmv"
readonly SUPPORTED_DOCUMENT_FORMATS="pdf|docx|md|html|odt|rtf|txt|epub"

show_help() {
    cat << EOF
Usage: $PROGRAM_NAME [options]

Options:
    -i <input>    Input file or directory
    -o <output>   Output file or directory (will be created if doesn't exist)
    -t <type>     Force conversion type (image|video|document)
    -f            Force overwrite existing files
    -v            Verbose output
    -h            Show this help message

Examples:
    $PROGRAM_NAME -i image.png -o image.jpg
    $PROGRAM_NAME -i video.mp4 -o video.avi
    $PROGRAM_NAME -i document.docx -o document.pdf
    $PROGRAM_NAME -i folder_of_pngs/ -o output_folder/
    $PROGRAM_NAME -i input.png -o output.jpg -f -v

Supported formats:
    Images: ${SUPPORTED_IMAGE_FORMATS//|/, }
    Videos: ${SUPPORTED_VIDEO_FORMATS//|/, }
    Documents: ${SUPPORTED_DOCUMENT_FORMATS//|/, }
EOF
}

log() {
    local level=$1
    shift
    local message=$*
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    case "$level" in
        "ERROR")   echo -e "${RED}[ERROR]${NC} $timestamp - $message" >&2 ;;
        "WARNING") echo -e "${YELLOW}[WARNING]${NC} $timestamp - $message" >&2 ;;
        "INFO")    [[ $VERBOSE == true ]] && echo -e "${GREEN}[INFO]${NC} $timestamp - $message" ;;
        "STATUS")  echo -e "${GREEN}[STATUS]${NC} $timestamp - $message" ;;  # New level for important non-error messages
    esac
}

check_file_exists() {
    local output_file=$1
    if [[ -e "$output_file" ]]; then
        if [[ "$FORCE" == true ]]; then
            log "INFO" "Overwriting existing file: $output_file"
            return 0
        else
            log "ERROR" "Output file already exists: $output_file. Use -f to force overwrite"
            return 1
        fi
    fi
    return 0
}

check_dependencies() {
    local missing_deps=()
    
    for cmd in magick ffmpeg pandoc; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing_deps+=("$cmd")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log "ERROR" "Missing dependencies: ${missing_deps[*]}"
        log "INFO" "Please install missing dependencies:"
        log "INFO" "  - ImageMagick for image conversion"
        log "INFO" "  - FFmpeg for video conversion"
        log "INFO" "  - Pandoc for document conversion"
        exit 1
    fi
}

detect_type() {
    local file_ext="${1##*.}"
    file_ext=$(echo "$file_ext" | tr '[:upper:]' '[:lower:]')
    
    if [[ "$file_ext" =~ ^($SUPPORTED_IMAGE_FORMATS)$ ]]; then
        echo "image"
    elif [[ "$file_ext" =~ ^($SUPPORTED_VIDEO_FORMATS)$ ]]; then
        echo "video"
    elif [[ "$file_ext" =~ ^($SUPPORTED_DOCUMENT_FORMATS)$ ]]; then
        echo "document"
    else
        echo "unknown"
    fi
}

validate_paths() {
    if [[ ! -e "$INPUT" ]]; then
        log "ERROR" "Input path does not exist: $INPUT"
        exit 1
    fi

    # For single file conversion
    if [[ ! -d "$INPUT" ]]; then
        local output_dir=$(dirname "$OUTPUT")
        if [[ ! -d "$output_dir" ]]; then
            mkdir -p "$output_dir"
            log "INFO" "Created output directory: $output_dir"
        fi
        
        if [[ -e "$OUTPUT" && "$FORCE" != true ]]; then
            log "ERROR" "Output file already exists. Use -f to force overwrite"
            exit 1
        fi
    fi
}

convert_image() {
    local input=$1
    local output=$2
    
    log "INFO" "Converting image: $input -> $output"
    if ! magick "$input" "$output" 2>/tmp/convert_error.log; then
        log "ERROR" "Failed to convert image: $input ($(cat /tmp/convert_error.log))"
        return 1
    fi
    return 0
}

convert_video() {
    local input=$1
    local output=$2
    
    log "INFO" "Converting video: $input -> $output"
    if ! ffmpeg -i "$input" -stats -v warning "$output" 2>/tmp/convert_error.log; then
        log "ERROR" "Failed to convert video: $input ($(cat /tmp/convert_error.log))"
        return 1
    fi
    return 0
}

convert_document() {
    local input=$1
    local output=$2
    
    log "INFO" "Converting document: $input -> $output"
    if ! pandoc "$input" -o "$output" 2>/tmp/convert_error.log; then
        log "ERROR" "Failed to convert document: $input ($(cat /tmp/convert_error.log))"
        return 1
    fi
    return 0
}

process_file() {
    local input=$1
    local output=$2
    local type=$3
    
    mkdir -p "$(dirname "$output")"
    
    if ! check_file_exists "$output"; then
        return 1
    fi
    
    case "$type" in
        "image")    convert_image "$input" "$output" ;;
        "video")    convert_video "$input" "$output" ;;
        "document") convert_document "$input" "$output" ;;
        *)          log "ERROR" "Unknown conversion type: $type"; return 1 ;;
    esac
}

get_extension_from_path() {
    local path=$1
    path=${path%/}
    local last_component=${path##*/}
    if [[ "$last_component" =~ ^[a-zA-Z0-9]+$ ]]; then
        echo "$last_component"
        return 0
    fi
    return 1
}

process_directory() {
    local input_dir=$1
    local output_dir=$2
    local type=$3
    local extension
    
    if extension=$(get_extension_from_path "$output_dir"); then
        output_dir=${output_dir%/*}
        if [[ -z "$output_dir" ]]; then
            output_dir="."
        fi
    else
        log "ERROR" "Please specify an output file extension (e.g., output_dir/jpg or jpg)"
        exit 1
    fi
    
    local total_files=0
    local converted=0
    local failed=0
    local skipped=0
    
    if [[ -d "$output_dir/$extension" ]]; then
        rmdir "$output_dir/$extension" 2>/dev/null || true
    fi
    
    mkdir -p "$output_dir"
    
    total_files=$(find "$input_dir" -type f -print0 | grep -zc .)
    
    if [[ $VERBOSE == true ]] || [[ $total_files -gt 1 ]]; then
        log "STATUS" "Processing $total_files files in directory: $input_dir"
        log "STATUS" "Output directory: $output_dir"
        log "STATUS" "Converting to: $extension"
    fi
    
    find "$input_dir" -type f -print0 | while IFS= read -r -d $'\0' file; do
        local base_name=$(basename "$file")
        local output_file="$output_dir/${base_name%.*}.$extension"
        
        if [[ -e "$output_file" ]] && [[ "$FORCE" != true ]]; then
            ((skipped++))
            log "INFO" "Skipped existing file: $base_name"
            continue
        fi
        
        if process_file "$file" "$output_file" "$type"; then
            ((converted++))
            log "INFO" "Successfully converted: $base_name"
        else
            ((failed++))
            log "WARNING" "Failed to convert: $base_name"
        fi
        
        if [[ $total_files -gt 1 ]]; then
            log "STATUS" "Progress: $converted converted, $failed failed, $skipped skipped, $((total_files - converted - failed - skipped)) remaining"
        fi
    done
    
    if [[ $total_files -gt 1 ]]; then
        log "STATUS" "Conversion complete: $converted converted, $failed failed, $skipped skipped out of $total_files total files"
    fi
    
    [[ $failed -eq 0 ]]
    return $?
}

INPUT=""
OUTPUT=""
FORCE=false
VERBOSE=false
FORCED_TYPE=""

while getopts "i:o:t:fvh" opt; do
    case $opt in
        i) INPUT="$OPTARG" ;;
        o) OUTPUT="$OPTARG" ;;
        t) FORCED_TYPE="$OPTARG" ;;
        f) FORCE=true ;;
        v) VERBOSE=true ;;
        h) show_help; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
    log "ERROR" "Missing mandatory options"
    show_help
    exit 1
fi

check_dependencies
validate_paths

if [[ -n "$FORCED_TYPE" ]]; then
    TARGET_TYPE="$FORCED_TYPE"
else
    TARGET_TYPE=$(detect_type "$OUTPUT")
fi

if [[ "$TARGET_TYPE" == "unknown" ]]; then
    log "ERROR" "Could not detect output type. Please specify with -t option"
    exit 1
fi

cleanup() {
    rm -f /tmp/convert_error.log
}
trap cleanup EXIT

if [[ -d "$INPUT" ]]; then
    process_directory "$INPUT" "$OUTPUT" "$TARGET_TYPE"
    exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        log "WARNING" "Some conversions failed. Check the logs above for details."
        exit $exit_code
    fi
else
    if ! process_file "$INPUT" "$OUTPUT" "$TARGET_TYPE"; then
        log "ERROR" "Conversion failed"
        exit 1
    fi
fi

exit 0
