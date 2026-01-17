{ lib, config, ... }:
{
  options = {
    wallpaper = {
      path = lib.mkOption { type = lib.types.str; };
      monitor = lib.mkOption { type = lib.types.str; };
    };
  };
  config = {
    home-manager.users.tom.services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        preload = [ config.wallpaper.path ];
        wallpaper = {
          monitor = config.wallpaper.monitor;
          path = config.wallpaper.path;
          fit_mode = "cover";
        };
      };
    };
  };
}
