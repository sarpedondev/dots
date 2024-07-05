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
        davinci-resolve
        nautilus
        exodus
        hoppscotch
        sushi
        totem
        whatsapp-for-linux
        mongodb-compass
        jetbrains.idea-ultimate
        jetbrains.webstorm
        jetbrains.pycharm-professional
        libsForQt5.polkit-kde-agent
        qbittorrent
        prismlauncher
        ffmpeg
        nur.repos.milahu.recaf-bin
        mongodb-compass
        unrar
        unzip
        eog
        obs-studio
        openssl
        htop
        neofetch
        ];
  };
  programs.steam.enable = true;
}
