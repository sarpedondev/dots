{ pkgs, config, lib, ... }:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      wl-clipboard
    ];
    services.cliphist.enable = true;
  };
}
