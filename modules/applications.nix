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
}
