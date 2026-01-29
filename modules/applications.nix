{ pkgs, ... }:
{
  home-manager.users.tom.home.packages = with pkgs; [
    filezilla
    vesktop
    spotify
    prismlauncher
    kdePackages.dolphin
    vlc
    jetbrains.idea
    (blender.override { rocmSupport = true; })
    pavucontrol
  ];
}
