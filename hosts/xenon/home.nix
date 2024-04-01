{ config, pkgs, ... }: {
  imports = [ 
    ../shared-home.nix
    ../../configs/hyprland.nix 
    ../../configs/waybar.nix
    ../../configs/rofi.nix
    ../../configs/kitty.nix
    ../../configs/git.nix
  ];
  hyprland.enable = true;
  hyprland.monitor = "LVDS-1,1366x768@60,0x0,1";
}
