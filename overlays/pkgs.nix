final: super: {
  conv = super.callPackage ./conv.nix { };
  davinci-resolve-custom = super.callPackage ./davinci.nix { };
  maven-indexer-cli = super.callPackage ./maven-indexer-cli.nix { };
  rea-agents = super.callPackage ./rea-agents.nix { };

  # upstream replaced the 8.1.0 tarball in place; drop once nixpkgs has the new hash
  anydesk = super.anydesk.overrideAttrs (old: {
    src = super.fetchurl {
      urls = old.src.urls;
      hash = "sha256-zS5P2eyTHZY7cBW8mQ2Q6M0lXcx9VZZTtpG3Bb6u7IQ=";
    };
  });
}
