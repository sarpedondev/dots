{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
    hyprpaper.monitor = lib.mkOption { };
    hyprpaper.wallpaper = lib.mkOption { };
  };

  config = lib.mkIf config.hyprpaper.enable {
    home-manager.users.tom = {
      home.packages = with pkgs; [
        hyprpaper
      ];
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${config.hyprpaper.wallpaper}
        wallpaper = ${config.hyprpaper.monitor},${config.hyprpaper.wallpaper}
      '';
    };
  };
}
