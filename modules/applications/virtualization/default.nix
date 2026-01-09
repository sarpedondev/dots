{ pkgs, ... }:
{
  #virtualisation.waydroid.enable = true;
  #users.users.tom = {
  #  extraGroups = [ "libvirtd" ];
  #};
  #virtualisation.libvirtd.enable = true;
  #programs.virt-manager.enable = true;
  #environment.systemPackages = with pkgs; [ dnsmasq ];
  #home-manager.users.tom.home.pointerCursor = {
  #  gtk.enable = true;
  #  package = pkgs.vanilla-dmz;
  #  name = "Vanilla-DMZ";
  #};
}
