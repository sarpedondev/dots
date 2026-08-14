{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      filezilla
      vesktop
      bun
      cfr
      stripe-cli

      eog
      ffmpeg
      fastfetch

      #davinci-resolve-custom
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
      (prismlauncher.override {
        additionalLibs = [ pkgs.openssl ];
      })
      kdePackages.dolphin
      grimblast
      gimp
      inkscape
      unzip
      google-chrome
      vlc
      tutanota-desktop

      (mongodb-compass.overrideAttrs (old: {
        buildCommand =
          builtins.replaceStrings
            [ "wrapGAppsHook $out/bin/mongodb-compass" ]
            [ "wrapGApp $out/bin/mongodb-compass" ]
            old.buildCommand
          + ''
            substituteInPlace $out/share/applications/mongodb-compass.desktop \
              --replace-fail "Exec=mongodb-compass %U" \
                             "Exec=mongodb-compass --password-store=gnome-libsecret --ignore-additional-command-line-flags %U"
          '';
      }))

      jetbrains.idea
      (blender.override { rocmSupport = true; })
      pavucontrol
      qFlipper
      gh

      apktool
      jadx
      file
      python3
      android-tools
      rizin
      binutils-unwrapped-all-targets
      apksigner
      frida-tools
      httptoolkit

      ghidra
    ];
  };
  services.teamviewer.enable = true;
  #programs.steam.enable = true;
  services.gvfs.enable = true;
  networking.firewall.allowedTCPPorts = [ 8080 ];
}
