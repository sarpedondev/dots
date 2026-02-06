{
  pkgs,
  ...
}:
{
  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
  nixpkgs.config.allowUnfree = true;
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
      pkgs.file
      pkgs.flite
      pkgs.zbar
      pkgs.fontconfig
      pkgs.freetype
      pkgs.dbus
    ];
  };
}
