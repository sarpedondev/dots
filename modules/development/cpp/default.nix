{ pkgs, ... }: {
  home-manager.users.tom.home = {
    sessionVariables = {
      PKG_CONFIG_PATH =
        "${pkgs.openssl.dev}/lib/pkgconfig:${pkgs.bzip2.dev}/lib/pkgconfig";
    };
    packages = with pkgs; [
      gcc
      xorg.libX11.dev
      #ninja
      cmake
      gnumake
      #meson
      vcpkg
      conan
      zip
    ];
  };
}
