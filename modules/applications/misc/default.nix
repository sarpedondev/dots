{ pkgs, ... }: {
  programs.steam.enable = true;
  home-manager.users.tom = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-tty;
    };
    home.packages = with pkgs; [
      python3
      hyprpicker
      vesktop
      grimblast
      vlc
      mpv
      vdhcoapp
      bottles
      gedit
      gimp
      filezilla
      tor-browser
      gnome-keyring
      apktool
      ghex
      spotify
      #davinci-resolve
      deepin.dde-file-manager

      pkg-config
      rustup
      xorg.xhost

      pkgs.guarda
      pkgs.conv
      hoppscotch
      sushi
      whatsapp-for-linux
      mongodb-compass
      jetbrains.idea-ultimate
      jetbrains.clion
      wmctrl
      jetbrains.pycharm-professional
      jetbrains.rider
      jetbrains.rust-rover
      libsForQt5.polkit-kde-agent
      qbittorrent
      prismlauncher
      ffmpeg
      nur.repos.milahu.recaf-bin
      mongodb-compass
      unrar
      unzip
      eog
      (wrapOBS { plugins = with obs-studio-plugins; [ droidcam-obs ]; })
      openssl
      htop
      neofetch

      (pkgs.writeShellScriptBin "gui" ''
        if [ $# -gt 0 ]; then
            ($@ &) &>/dev/null
        else
            echo "missing argument"
        fi
      '')
    ];
  };
}
