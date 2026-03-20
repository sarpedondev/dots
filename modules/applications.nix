{ pkgs, ... }:
{
  home-manager.users.tom.home.packages = with pkgs; [
    filezilla
    vesktop
    bun
    claude-code
    nodejs
    recaf-launcher
    zig
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
  ];
  services.teamviewer.enable = true;
}
