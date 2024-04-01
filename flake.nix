{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR"; 
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, ... }@inputs: 
    let 
      overlays = [
        inputs.nur.overlay
      ];
    in
    {
      nixosConfigurations = {
        neon = import ./hosts/neon { inherit inputs overlays; };
        xenon = import ./hosts/xenon { inherit inputs overlays; };
      };
    };
}
