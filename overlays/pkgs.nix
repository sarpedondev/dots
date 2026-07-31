final: super: {
  conv = super.callPackage ./conv.nix { };
  davinci-resolve-custom = super.callPackage ./davinci.nix { };
  maven-indexer-cli = super.callPackage ./maven-indexer-cli.nix { };
}
