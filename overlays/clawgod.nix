{
  lib,
  stdenv,
  fetchurl,
  writeShellScriptBin,
  makeWrapper,
  autoPatchelfHook,
  alsa-lib,
  bun,
  nodejs,
  ripgrep,
  clawgodSrc,
}:
let
  claudeVersion = "2.1.296";

  native = fetchurl {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code-linux-x64/-/claude-code-linux-x64-${claudeVersion}.tgz";
    hash = "sha256-7vWi4rCaXn0s54TRs7ozWuf8bH9iVsgCoOvywh5P0OE=";
  };

  fakeNpm = writeShellScriptBin "npm" ''
    [ "$1" = pack ] && cp ${native} ./claude-code.tgz
  '';
in
stdenv.mkDerivation {
  pname = "clawgod";
  version = claudeVersion;
  src = clawgodSrc;

  nativeBuildInputs = [
    fakeNpm
    autoPatchelfHook
    makeWrapper
    bun
    nodejs
    ripgrep
  ];
  buildInputs = [
    stdenv.cc.cc.lib
    alsa-lib
  ];

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  installPhase = ''
    runHook preInstall

    home=$out/share/clawgod
    mkdir -p $home $out/bin
    HOME=$home CLAWGOD_VERSION=${claudeVersion} bash ./install.sh

    mv $home/.local/bin/claude.orig $out/bin/claude.orig
    rm -rf $home/.local $home/.claude
    mkdir -p $out/share/clawgod/defaults
    mv $home/.clawgod/features.json $out/share/clawgod/defaults/
    rm -f $home/.clawgod/{patches.json,startup-check.log,claude.staged}

    makeWrapper ${lib.getExe bun} $out/bin/claude \
      --add-flags $home/.clawgod/cli.cjs \
      --set CLAUDE_CODE_EXECPATH $out/bin/claude.orig \
      --set-default HERDR_AGENT claude \
      --set DISABLE_AUTOUPDATER 1 \
      --prefix PATH : ${lib.makeBinPath [ ripgrep ]}
    ln -s claude $out/bin/clawgod

    runHook postInstall
  '';

  meta = {
    description = "Runtime patch for Claude Code";
    homepage = "https://github.com/0Chencc/clawgod";
    license = lib.licenses.gpl3Only;
    mainProgram = "claude";
    platforms = [ "x86_64-linux" ];
  };
}
