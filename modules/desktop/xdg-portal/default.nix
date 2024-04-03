{ pkgs, config, lib, ... }:
{
  home-manager.users.tom = {
    xdg.portal = {
      enable = true;
      config = { common = { default = [      "gtk"    ]; }; };
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    };
  };
}
