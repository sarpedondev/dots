{ config, pkgs, inputs,  ... }: {
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
  ];
  
  networking.hostName = "xenon";
}
