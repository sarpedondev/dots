{ pkgs, ... }:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      python3
      hyprpicker
      vesktop
      grimblast
      vlc
      mpv
      vdhcoapp
      bottles
      firefox
      gedit
      gimp
      filezilla
      spotify
      davinci-resolve
      nautilus
      exodus
      hoppscotch
      sushi
      whatsapp-for-linux
      mongodb-compass
      jetbrains.idea-ultimate
      jetbrains.webstorm
      jetbrains.pycharm-professional
      libsForQt5.polkit-kde-agent
      qbittorrent
      code-cursor
      prismlauncher
      geckodriver
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
  #programs.steam.enable = true;
}
