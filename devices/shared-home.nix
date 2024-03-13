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
  
  programs.gpg.enable = true;

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
}
