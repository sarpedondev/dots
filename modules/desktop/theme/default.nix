{ config, pkgs, ... }:
{
  #qt = {
  #  enable = true;
  #  platformTheme = "qt5ct";
  #  style = "kvantum";
  #};

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # Replace some accent colors with mauve
    override = {
      base06 = "#cba6f7"; # rosewater
      base08 = "#cba6f7"; # red
      base09 = "#cba6f7"; # peach
      base0A = "#cba6f7"; # yellow
      base0B = "#cba6f7"; # green
      base0C = "#cba6f7"; # teal
      base0D = "#cba6f7"; # blue
      base0F = "#cba6f7"; # flamingo
    };
    image = config.hyprpaper.wallpaper;
    polarity = "dark";

    fonts = {
      serif = {
        package = (pkgs.nerdfonts.override { fonts = [ "Noto" ]; });
        name = "NotoSerif Nerd Font";
      };
      sansSerif = {
        package = (pkgs.nerdfonts.override { fonts = [ "Noto" ]; });
        name = "NotoSans Nerd Font";
      };
      monospace = {
        package = (pkgs.nerdfonts.override { fonts = [ "Noto" ]; });
        name = "NotoSansM Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 16;
    };
  };

  home-manager.users.tom = {
    stylix.targets = {
      hyprland.enable = false;
      hyprpaper.enable = false;
      #rofi.enable = false;
      neovim.enable = false;
    };
    #home.file.".local/share/icons/catppuccin-mocha-mauve-cursors".source = "${pkgs.catppuccin-cursors.mochaMauve}/share/icons/catppuccin-mocha-mauve-cursors";
    home.file.".local/share/icons/Fluent".source = "${pkgs.fluent-icon-theme}/share/icons/Fluent";
    # gtk = {
    #  enable = true;
    #  theme = {
    #    name = "catppuccin-mocha-mauve-standard";
    #    package = (
    #     pkgs.catppuccin-gtk.override {
    #        accents = [ "mauve" ];
    #        variant = "mocha";
    #      }
    #    );
    #  };
    #  cursorTheme = {
    #    name = "catppuccin-mocha-mauve-cursors";
    #    package = pkgs.catppuccin-cursors.mochaMauve;
    #    size = 16;
    #  };
    #  iconTheme = {
    #    name = "Fluent";
    #    package = pkgs.fluent-icon-theme;
    #  };
    #  font = {
    #   name = "Roboto";
    #    package = pkgs.roboto;
    #  };
    #};

    # xdg.configFile = {
    #  "Kvantum/catppuccin-mocha-mauve".source = "${
    #    (pkgs.catppuccin-kvantum.override {
    #      accent = "mauve";
    #      variant = "mocha";
    #  })
    #}/share/Kvantum/catppuccin-mocha-mauve";
    #"Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    #  General.theme = "catppuccin-mocha-mauve";
    #};
    #"qt5ct/qt5ct.conf".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    #  Appearance.icon_theme = "Fluent";
    #};
    #};

    #qt = {
    #enable = true;
    #platformTheme.name = "qtct";
    #style.name = "kvantum";
    #};

    fonts.fontconfig.enable = true;
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Noto" ]; })
      (catppuccin-kvantum.override {
        accent = "mauve";
        variant = "mocha";
      })
    ];
  };
}
