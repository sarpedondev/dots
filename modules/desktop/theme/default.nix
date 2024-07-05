{ pkgs, config, lib, ... }: 
{
  home-manager.users.tom = {
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-mauve-standard";
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
      font = {
        name = "Roboto";
        package = pkgs.roboto;
      };
    };
    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    ];
  };
}
