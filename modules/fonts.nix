{ pkgs, ... }:
{
  home-manager.users.tom = {

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

      #nerd-fonts.jetbrains-mono # ttf-jetbrains-mono-nerd
      #material-symbols # ttf-material-symbols-variable-git
      #ttf-readex-pro (TODO: seems not available as nixpkg)
      #rubik # ttf-rubik-vf
      #twemoji-color-font # ttf-twemoji
    ];
  };
}
