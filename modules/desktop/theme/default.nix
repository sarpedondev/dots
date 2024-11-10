{
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };

  environment.variables = {
    XCURSOR_THEME = "catppuccin-mocha-mauve-cursors";
    XCURSOR_SIZE = "16"; 
  };

  home-manager.users.tom = { config, pkgs, ... }: {
    home.file.".local/share/icons/catppuccin-mocha-mauve-cursors".source = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons/catppuccin-mocha-mauve-cursors"; 
    home.file.".local/share/icons/Fluent".source = "${pkgs.fluent-icon-theme}/share/icons/Fluent";
    gtk = {
      enable = true;
      theme = {
        name = "catppuccin-mocha-mauve-standard";
        package = (pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; });
      };
      cursorTheme = {
        name = "catppuccin-mocha-mauve-cursors";
        package = pkgs.catppuccin-cursors.mochaMauve;
        size = 16;
      };
      iconTheme = {
        name = "Fluent";
        package = pkgs.fluent-icon-theme;
      };
      font = {
        name = "Roboto";
        package = pkgs.roboto;
      };
    };

    xdg.configFile = {
      "Kvantum/Catppuccin-Mocha-Mauve".source = "${(pkgs.catppuccin-kvantum.override { accent = "Mauve"; variant = "Mocha"; })}/share/Kvantum/Catppuccin-Mocha-Mauve";
      "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        General.theme = "Catppuccin-Mocha-Mauve";
      };
      "qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
        Appearance.icon_theme = "Fluent";
      };
    };

    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style.name = "kvantum";
    };

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
      (catppuccin-kvantum.override { accent = "Mauve"; variant = "Mocha"; })
    ];
  };
}
