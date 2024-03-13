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

  outputs = { self, nixpkgs, nur, home-manager, ... }: {
    nixosConfigurations = {
      neon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
	  nur.nixosModules.nur
          ./devices/neon/configuration.nix
          { home-manager.users.tom = import ./devices/neon/home.nix; }
        ];
      };
  
      xenon = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          ./devices/xenon/configuration.nix
          { home-manager.users.tom = import ./devices/xenon/home.nix; }
        ];
      };
    };
  };
}
