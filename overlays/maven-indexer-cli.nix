{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "maven-indexer-cli";
  version = "e80634b7ed08104b69c870146fea3f98678701ce";

  src = fetchFromGitHub {
    owner = "tangcent";
    repo = "maven-indexer-cli";
    rev = "${version}";
    hash = "sha256-a+BbDLt4oCeJfMUf83bpV+y40GHZ+k1d0dsdTObo0Cw=";
  };

  npmDepsHash = "sha256-a1jHPc5XvhTU9y9Di47GRbwqR5Bh1vP6PokeTK0HxL0=";

  npmBuildScript = "build";

  postInstall = ''
    install -Dm444 ${src}/lib/cfr-0.152.jar \
      $out/lib/node_modules/maven-indexer-cli/dist/lib/cfr-0.152.jar
  '';

  meta = {
    description = "Query a local Maven/Gradle artifact index";
    homepage = "https://github.com/tangcent/maven-indexer-cli";
    license = lib.licenses.isc;
    mainProgram = "maven-indexer-cli";
  };
}
