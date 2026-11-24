usage() {
  cat <<EOF
Download and decrypt the server backups from the Hetzner Storage Box.

Usage:
  server-backup list
  server-backup restore <directory> [databases|files|all|<snapshot-id>] [restic restore options]
  server-backup browse <mountpoint>

Examples:
  server-backup restore ~/restore                     latest database dumps
  server-backup restore ~/restore files               latest files (large)
  server-backup restore ~/restore all                 both
  server-backup restore ~/restore 7fc7f5c5            one specific snapshot
  server-backup restore ~/restore files --include '*baikal*'
  server-backup browse ~/backup-mnt                   mount all snapshots read-only

Credentials come from sops (server-backup/host, username, path, password).
The SSH key comes from the 1Password SSH agent.
EOF
}

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

read_secret() {
  local file="$1" value
  [ -r "$file" ] || die "secret $file is missing or unreadable"
  value="$(tr -d '\r\n' < "$file")"
  [ -n "$value" ] || die "secret $file is empty"
  printf '%s' "$value"
}

connect() {
  local host username path
  host="$(read_secret "$SECRET_HOST_FILE")"
  username="$(read_secret "$SECRET_USERNAME_FILE")"
  path="$(read_secret "$SECRET_PATH_FILE")"
  read_secret "$SECRET_PASSWORD_FILE" >/dev/null

  ssh -p 23 "$username@$host" pwd >/dev/null ||
    die "SSH login to the Storage Box failed (is the key in the 1Password SSH agent?)"

  export RESTIC_REPOSITORY="sftp:$username@$host:$path"
  export RESTIC_PASSWORD_FILE="$SECRET_PASSWORD_FILE"
  SFTP_COMMAND="sftp.command=ssh -p 23 $username@$host -s sftp"
}

restic_read() {
  restic --no-lock -o "$SFTP_COMMAND" "$@"
}

human_bytes() {
  numfmt --to=iec-i --suffix=B --format='%.1f' "$1"
}

confirm() {
  local answer
  read -r -p "$1 [y/N] " answer
  [[ "$answer" =~ ^[yYjJ]$ ]]
}

restore_snapshot() {
  local directory="$1" label="$2"
  shift 2
  local size available

  size="$(restic_read stats --json --quiet --mode restore-size "$@" | jq '.total_size')"
  available="$(df --output=avail --block-size=1 "$directory" | tail -n 1)"

  printf '%s: %s to download, %s free in %s\n' \
    "$label" "$(human_bytes "$size")" "$(human_bytes "$available")" "$directory"
  (( size < available )) || die "not enough free space in $directory"
}

run_restore() {
  local directory="${1:-}" selection=databases
  [ -n "$directory" ] || die "missing target directory (see: server-backup help)"
  shift
  if [ $# -gt 0 ] && [[ "$1" != -* ]]; then
    selection="$1"
    shift
  fi

  local -a snapshots
  case "$selection" in
    databases | files) snapshots=("latest --tag $selection") ;;
    all) snapshots=("latest --tag databases" "latest --tag files") ;;
    *) snapshots=("$selection") ;;
  esac

  mkdir -p "$directory"
  chmod 700 "$directory"
  directory="$(realpath "$directory")"

  connect

  local snapshot
  local -a args
  for snapshot in "${snapshots[@]}"; do
    read -r -a args <<< "$snapshot"
    restore_snapshot "$directory" "$snapshot" "${args[@]}"
  done
  confirm "Download and decrypt into $directory?" || exit 0

  for snapshot in "${snapshots[@]}"; do
    read -r -a args <<< "$snapshot"
    printf '\nRestoring %s\n' "$snapshot"
    restic_read restore "${args[@]}" --target "$directory" "$@"
  done

  printf '\nDone. Restored data is in %s\n' "$directory"
  if [ -d "$directory/var/lib/server-backup/staging" ]; then
    printf 'Database dumps: %s\n' "$directory/var/lib/server-backup/staging"
  fi
  printf 'It contains unencrypted production data; delete it when you are finished.\n'
}

run_browse() {
  local mountpoint="${1:-}"
  [ -n "$mountpoint" ] || die "missing mountpoint (see: server-backup help)"
  mkdir -p "$mountpoint"
  connect
  printf 'Mounting snapshots read-only at %s, press Ctrl+C to unmount\n' "$mountpoint"
  restic_read mount "$mountpoint"
}

command="${1:-help}"
shift || true
case "$command" in
  list)
    connect
    restic_read snapshots "$@"
    ;;
  restore) run_restore "$@" ;;
  browse) run_browse "$@" ;;
  help | -h | --help) usage ;;
  *)
    usage >&2
    exit 1
    ;;
esac
