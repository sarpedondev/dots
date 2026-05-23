{ pkgs, ... }:
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
    prismlauncher
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
  ];
  services.teamviewer.enable = true;
  programs.steam.enable = true;
  services.gvfs.enable = true;
}
