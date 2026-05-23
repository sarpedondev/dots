{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop.url = "github:aaddrick/claude-desktop-debian";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      overlays = {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
          inputs.claude-desktop.overlays.default
          (import ./overlays/pkgs.nix)
          (import ./overlays/_1password-cli-beta.nix)
        ];
      };
    in
    {
      nixosConfigurations = {
        neon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/neon
            overlays
          ];
        };
        helium = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/helium
            overlays
          ];
        };
      };
    };
}
