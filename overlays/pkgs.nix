final: super: {
  conv = super.callPackage ./conv.nix { };
  guarda = super.callPackage ./guarda.nix { };
  davinci-resolve-custom = super.callPackage ./davinci.nix { };
  jetbrains-fleet = super.callPackage ./jetbrains-fleet.nix { };
}
