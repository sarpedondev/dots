{ pkgs, ... }:
{
  nixpkgs.config.android_sdk.accept_license = true;
  programs.steam.enable = true;
  home-manager.users.tom = {
    programs.gpg.enable = true;
    services.gpg-agent = {
      enable = true;
      pinentry.package = pkgs.pinentry-tty;
    };
    home.packages = with pkgs; [
      nmap
      python3
      hyprpicker
      vesktop
      grimblast
      vlc
      vdhcoapp
      bottles
      gedit
      gimp
      filezilla
      tor-browser
      gnome-keyring
      ghex
      spotify

      brave

      davinci-resolve-custom

      nautilus
      ffmpegthumbnailer

      jq

      vulkan-loader
      vulkan-tools

      android-studio
      android-tools
      apktool
      jadx
      apksigner

      pkg-config
      trezor-suite
      monero-gui
      rustup
      zig
      ruby_3_4
      zls
      xorg.xhost

      httptoolkit

      gemini-cli
      nicotine-plus

      pkgs.guarda
      ncdu
      pkgs.conv
      hoppscotch
      sushi
      wasistlos
      mongodb-compass
      jetbrains.idea-ultimate
      jetbrains.ruby-mine

      wmctrl
      jetbrains.pycharm-professional
      kdePackages.polkit-kde-agent-1
      qbittorrent
      prismlauncher
      ffmpeg
      nur.repos.milahu.recaf-bin
      mongodb-compass
      unrar
      unzip
      eog
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
