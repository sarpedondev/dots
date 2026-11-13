{
  lib,
  stdenv,
  buildNpmPackage,
  fetchurl,
  nodejs_24,
  jq,
  autoPatchelfHook,
}:
let
  # The published archive includes the compiled runtime and matching skill.
  lockfile = fetchurl {
    url = "https://raw.githubusercontent.com/morluto/rea/rea-agents-6.9.0/package-lock.json";
    hash = "sha256-PLzox45vpKtpYY3PmifqHzRnC8FmTqd3/XmTkB4IoWM=";
  };
in
buildNpmPackage rec {
  pname = "rea-agents";
  version = "6.9.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/rea-agents/-/rea-agents-${version}.tgz";
    hash = "sha512-KqDn1UR5BMqHoQ3MGAnPuWiSKwgdFaz1L/uUNgrKt+1W8kPtgYP8AWEOXIF1lDIOBVyPuYIIst2iamo1Wf3r8g==";
  };

  nodejs = nodejs_24;
  npmDepsHash = "sha256-6hRmFRsPY6U5O0tpwA3mAUZIic5cO+M/kAs326Q3lNI=";
  dontNpmBuild = true;
  npmInstallFlags = [ "--omit=dev" ];
  npmRebuildFlags = [ "--ignore-scripts" ];
  npmPackFlags = [ "--ignore-scripts" ];

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [ stdenv.cc.cc.lib ];

  postPatch = ''
    cp ${lockfile} package-lock.json
    # Only runtime dependencies are needed for the precompiled release.
    ${jq}/bin/jq 'del(.devDependencies)' package.json > package.json.tmp
    mv package.json.tmp package.json
    ${jq}/bin/jq 'del(.packages[""].devDependencies) | .packages |= with_entries(select(.value.dev != true))' \
      package-lock.json > package-lock.json.tmp
    mv package-lock.json.tmp package-lock.json
  '';

  meta = {
    description = "Reverse engineering tools for agents and the terminal";
    homepage = "https://github.com/morluto/rea";
    license = lib.licenses.mit;
    mainProgram = "rea";
    platforms = lib.platforms.linux;
  };
}
