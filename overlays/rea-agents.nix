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
    url = "https://raw.githubusercontent.com/morluto/rea/a56f7bb668ab23fec8d33f7af353ac7ed2fe1895/package-lock.json";
    hash = "sha256-tlXiEYl71yAy72kmG+hxDlA3se3neBBsj+9zAwetAFk=";
  };
in
buildNpmPackage rec {
  pname = "rea-agents";
  version = "6.4.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/rea-agents/-/rea-agents-${version}.tgz";
    hash = "sha256-WesWBLjbdfUi1Kl1w2zmtKKtRl5DutFl+aj3KDkdubg=";
  };

  nodejs = nodejs_24;
  npmDepsHash = "sha256-swbjGsWX/zoQXgR2F5R22Ff8qedS4ZHCz67QBf7phaE=";
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
