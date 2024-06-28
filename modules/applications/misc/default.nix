{ pkgs, ... }:
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
 #       exodus
        hoppscotch
        gnome.sushi
        gnome.totem
        whatsapp-for-linux
        mongodb-compass
        jetbrains.idea-ultimate
        jetbrains.webstorm
        libsForQt5.polkit-kde-agent
        qbittorrent
        prismlauncher
        nur.repos.milahu.recaf-bin
        mongodb-compass
        unrar
        unzip
        gnome.eog
        obs-studio
        openssl
        ];
  };
  programs.steam.enable = true;
}
