{ pkgs, ... }:
{
  home-manager.users.tom.home.packages = with pkgs; [
    filezilla
    vesktop
    bun
    nodejs
    spotify
    prismlauncher
    kdePackages.dolphin
    grimblast
    vlc
    mongodb-compass
    jetbrains.idea
    (blender.override { rocmSupport = true; })
    pavucontrol
  ];
}
