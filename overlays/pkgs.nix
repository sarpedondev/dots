self: super: {
  conv = super.callPackage ./conv.nix { };
  guarda = super.callPackage ./guarda.nix { };
}
