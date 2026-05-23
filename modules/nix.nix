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
      pkgs.libXcursor
      pkgs.libXrandr
      pkgs.libX11
      pkgs.libXxf86vm
      pkgs.libXi
      pkgs.libXtst
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
