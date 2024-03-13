{ config, pkgs, inputs,  ... }: {
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "neon";

  networking.wireguard.enable = true;
  services.resolved.enable = true;

  services.mullvad-vpn.enable = true;
  
  # HIP and ROCM
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  hardware.opengl.extraPackages = [ 
    pkgs.rocmPackages.clr.icd 
    pkgs.amdvlk 
  ];
}
