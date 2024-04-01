{ config, pkgs, ...}: {
  xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = /home/tom/Downloads/wallpaper.jpg
    wallpaper = DP-1,/home/tom/Downloads/wallpaper.jpg
  '';
}
