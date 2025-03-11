{ pkgs, ... }: {
  home-manager.users.tom.home.packages = with pkgs; [
    gcc
    xorg.libX11.dev
    ninja
  ];
}
