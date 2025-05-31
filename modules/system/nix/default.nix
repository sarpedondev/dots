{ pkgs, config, lib, ... }: {
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
  home-manager.users.tom = {
    home.username = "tom";
    home.homeDirectory = "/home/tom";
    home.stateVersion = "23.11";
  };
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.xorg.libXcursor
      pkgs.xorg.libXrandr
      pkgs.xorg.libX11
      pkgs.xorg.libXxf86vm
      pkgs.xorg.libXi
      pkgs.xorg.libXtst
      pkgs.wayland
      pkgs.libxkbcommon
      pkgs.libglvnd
      pkgs.bzip2
      pkgs.gtk3
      pkgs.curl
      pkgs.openssl
      pkgs.glibc
      pkgs.glib
    ];
  };
}
