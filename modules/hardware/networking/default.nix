{
  pkgs,
  config,
  lib,
  ...
}:
{
  networking.networkmanager.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  networking.firewall.enable = false;
  #systemd.services.NetworkManager-wait-online.enable = false;
  networking.useDHCP = lib.mkDefault true;
  services.printing.enable = true;
}
