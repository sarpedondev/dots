{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "maven-indexer-cli";
  version = "5131095497afda9f6f58a24ec6daa0173c1b9077";

  src = fetchFromGitHub {
    owner = "tangcent";
    repo = "maven-indexer-cli";
    rev = "${version}";
    hash = "sha256-76ZrLcRQtnNd/VOphC86h9yElK1mv553pcp/Up05Yu0=";
  };

  npmDepsHash = "sha256-bTbtT5XHDJSbsN2cE3BAo0i5YWbja68U1yT98S73LVA=";

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
