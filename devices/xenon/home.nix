{ config, pkgs, ... }: {
  imports = [ 
    ../shared-home.nix
    ../../configs/hyprland.nix 
    ../../configs/waybar.nix
    ../../configs/rofi.nix
    ../../configs/kitty.nix
    ../../configs/git.nix
  ];
}
