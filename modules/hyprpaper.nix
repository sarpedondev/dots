{ lib, config, ... }:
{
  options = {
    wallpaper = lib.mkOption { type = lib.types.str; };
  };
  config = {
    home-manager.users.tom.services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [ config.wallpaper ];
        wallpaper = {
          monitor = "LVDS-1";
          path = config.wallpaper;
          fit_mode = "cover";
        };
      };
    };
  };
}
