{ config, pkgs, ... }: {
  imports = [ 
    ../shared-home.nix
    ../../configs/hyprland.nix 
    ../../configs/hyprpaper.nix
    ../../configs/waybar.nix
    ../../configs/rofi.nix
    ../../configs/kitty.nix
    ../../configs/git.nix
  ];

  home.packages = with pkgs; [
    mullvad-vpn
    qbittorrent
  ];
}
