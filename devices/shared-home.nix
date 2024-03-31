{ config, pkgs, ... }: {
  home.username = "tom";
  home.homeDirectory = "/home/tom";
  home.stateVersion = "23.11";
  
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Mauve";
      package = (pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; });
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Mauve-Cursors";
      package = pkgs.catppuccin-cursors.mochaMauve;
      size = 16;
    };
    iconTheme = {
      name = "Qogir";
      package = (pkgs.qogir-icon-theme.override { colorVariants = [ "dark" ]; themeVariants = [ "default" ]; });
    };
  };

  xdg.portal = {
    enable = true;
    config = { common = { default = [      "gtk"    ]; }; };
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  home.packages = with pkgs; [
    python3
    neovim
    kitty-themes
    hyprpaper
    hyprpicker
    wl-clipboard
    roboto
    (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    vesktop
    grimblast
    vlc
    firefox
    gedit
    gimp
    spotify
    davinci-resolve
    gnome.nautilus
    gnome.sushi
    gnome.totem
    #gnome.gnome-disk-utility
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.clion
    android-studio
    docker-compose
    libsForQt5.polkit-kde-agent
    github-copilot-intellij-agent
    prismlauncher
    unrar
    unzip
    sidequest
  ];

  services.cliphist.enable = true;

  programs.gpg.enable = true;

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
}
