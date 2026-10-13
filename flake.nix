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
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
    clawgod = {
      url = "github:0Chencc/clawgod";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      codex-cli-nix,
      ...
    }@inputs:
    let
      overlays = {
        nixpkgs.overlays = [
          inputs.nur.overlays.default
          (import ./overlays/pkgs.nix)
          (final: prev: {
            clawgod = prev.callPackage ./overlays/clawgod.nix { clawgodSrc = inputs.clawgod; };
          })
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
