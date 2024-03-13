{ config, pkgs, ... }: {

  imports = [ 
    ../shared-home.nix
    ../../configs/hyprland.nix 
    ../../configs/waybar.nix
  ];

  home.packages = [
    pkgs.python3
    pkgs.neovim
    pkgs.kitty-themes
    pkgs.roboto
    pkgs.roboto-mono
    pkgs.vesktop
    pkgs.mullvad-vpn
    pkgs.grimblast
    pkgs.qbittorrent
    pkgs.vlc
    pkgs.firefox
    pkgs.gedit
    #pkgs.davinci-resolve
  ];

  programs.home-manager.enable = true;
  
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "RobotoMono Nerd Font Mono";
      size = 11.0;
    };
    settings = {
      window_padding_width = 15;
      hide_window_decorations = true;
      allow_remote_control = true;
      confirm_os_window_close = 0;
    };
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
  };
  
    programs.git = {
    enable = true;
  };


}
