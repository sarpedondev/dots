{ config, pkgs, inputs,  ... }: {
  imports = [
    ../shared.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "neon";

  networking.wireguard.enable = true;
  services.resolved.enable = true;

  services.mullvad-vpn.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # HIP, ROCM and opengl
  hardware.opengl.enable = true;
  systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
  hardware.opengl.extraPackages = [ 
    pkgs.rocmPackages.clr.icd 
    pkgs.amdvlk 
  ];
}
