{ pkgs, lib, ... }:
{
  home-manager.users.tom.home.packages = with pkgs; [
    filezilla
    vesktop
    bun
    claude-code
    codex
    cfr

    ffmpeg
    fastfetch

    davinci-resolve-custom
    audacity

    nodejs
    recaf-launcher
    zig
    qbittorrent
    p7zip
    imagemagick
    jq
    unzip
    spotify
    (prismlauncher.override {
      additionalLibs = [ pkgs.openssl ];
    })
    kdePackages.dolphin
    grimblast
    unzip
    google-chrome
    vlc
    mongodb-compass
    jetbrains.idea
    (blender.override { rocmSupport = true; })
    pavucontrol
    qFlipper
    gh

    apktool
    jadx
    file
    python3
    android-tools
    rizin
    binutils-unwrapped-all-targets
    apksigner
    frida-tools
    httptoolkit
  ];
  services.teamviewer.enable = true;
  programs.steam.enable = true;
  services.gvfs.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 ];
  services.dnsmasq = {
    enable = true;
    settings = {
      address = [
        "/nemo.apps.tapulous.com/192.168.178.44"
        "/nemo.pragueweb.tapulous.com/192.168.178.44"
      ];
    };
  };
}
