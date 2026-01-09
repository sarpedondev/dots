{ config, pkgs, ... }:
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

  home-manager.users.tom =
    { config, pkgs, ... }:
    {
      home.file.".local/share/icons/catppuccin-mocha-mauve-cursors".source =
        "${pkgs.catppuccin-cursors.mochaMauve}/share/icons/catppuccin-mocha-mauve-cursors";
      home.file.".local/share/icons/Fluent".source = "${pkgs.fluent-icon-theme}/share/icons/Fluent";
      gtk = {
        enable = true;
        theme = {
          name = "catppuccin-mocha-mauve-standard";
          package = (
            pkgs.catppuccin-gtk.override {
              accents = [ "mauve" ];
              variant = "mocha";
            }
          );
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
          name = "NotoSerif Nerd Font";
          package = pkgs.nerd-fonts.noto;
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = 1;
        };
      };

      xdg.configFile = {
        "Kvantum/catppuccin-mocha-mauve".source = "${
          (pkgs.catppuccin-kvantum.override {
            accent = "mauve";
            variant = "mocha";
          })
        }/share/Kvantum/catppuccin-mocha-mauve";
        "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
          General.theme = "catppuccin-mocha-mauve";
        };
        "qt5ct/qt5ct.conf".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
          Appearance.icon_theme = "Fluent";
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
      };

      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [ "NotoSerif Nerd Font" ];
          sansSerif = [ "NotoSans Nerd Font" ];
          monospace = [ "NotoSansM Nerd Font" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
      home.packages = with pkgs; [
        nerd-fonts.noto
        noto-fonts-color-emoji
        (catppuccin-kvantum.override {
          accent = "mauve";
          variant = "mocha";
        })
      ];
    };
}
