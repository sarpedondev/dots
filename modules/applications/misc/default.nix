{ pkgs, ... }: {
  nixpkgs.config.android_sdk.accept_license = true;
  programs.steam.enable = true;
  home-manager.users.tom = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-tty;
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
      kdePackages.xwaylandvideobridge
      gedit
      gimp
      filezilla
      tor-browser
      gnome-keyring
      ghex
      spotify

      brave

      davinci-resolve-custom
      deepin.dde-file-manager
      jq

      android-studio
      android-tools
      apktool

      pkg-config
      exodus
      trezor-suite
      monero-gui
      rustup
      zig
      zls
      xorg.xhost

      httptoolkit

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
