{ pkgs, config, lib, ... }:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      python3
        hyprpicker
        nodejs
        vesktop
        grimblast
        vlc
        bottles
        firefox
        gedit
        gimp
        spotify
        #davinci-resolve
        gnome.nautilus
        hoppscotch
        gnome.sushi
        gnome.totem
        whatsapp-for-linux
        jetbrains.idea-ultimate
        libsForQt5.polkit-kde-agent
        qbittorrent
        prismlauncher
        nur.repos.milahu.recaf-bin
        unrar
        unzip
        ];
  };
}
