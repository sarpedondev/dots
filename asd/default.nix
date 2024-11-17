{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation rec {
  pname = "conv";
  version = "1.0.0";

  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [
    imagemagick   # For image conversions
    ffmpeg        # For video conversions
    pandoc        # For document conversions
  ];

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/doc/${pname}

    install -Dm755 conv.sh $out/bin/conv

    wrapProgram $out/bin/conv \
      --prefix PATH : ${lib.makeBinPath buildInputs}

    cp README.md $out/share/doc/${pname}/README.md
  '';

  meta = with lib; {
    description = "A versatile file format conversion utility";
    longDescription = ''
      File Converter is a bash script that provides a unified interface for
      converting between various file formats. It supports:
      - Image formats (jpg, png, gif, etc.)
      - Video formats (mp4, avi, mkv, etc.)
      - Document formats (pdf, docx, md, etc.)
      
      The tool provides both single-file and batch conversion capabilities.
    '';
    homepage = "https://github.com/TomJuri/conv";
    license = licenses.mit;
    platforms = platforms.unix;
    mainProgram = "conv";
  };
}
