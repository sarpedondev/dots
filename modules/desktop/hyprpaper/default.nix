{ pkgs, config, lib, ...}: 
{
  options = {
    hyprpaper.enable = lib.mkEnableOption "Enables hyprpaper";
    hyprpaper.monitor = lib.mkOption {};
    hyprpaper.wallpaper = lib.mkOption {};
  };

  config = lib.mkIf config.hyprpaper.enable {
    home-manager.users.tom = {
      home.packages = with pkgs; [
        hyprpaper
         python3
          neovim
            
            hyprpicker
            nodejs
            bottles
            
           # davinci-resolve
            vesktop
            grimblast
          vlc
            firefox
            gedit
            gimp
            spotify
            gnome.nautilus
            gnome.sushi
           gnome.totem
            jetbrains.pycharm-professional
            jetbrains.webstorm
            jetbrains.idea-ultimate
            docker-compose
            libsForQt5.polkit-kde-agent
            github-copilot-intellij-agent
	    gradle
            prismlauncher
            unrar
           unzip
      ];
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${config.hyprpaper.wallpaper}
      wallpaper = ${config.hyprpaper.monitor},${config.hyprpaper.wallpaper}
      '';
    };
      services.gvfs.enable = true;
            # HIP, ROCM and OpenGL
       hardware.opengl.enable = true;
       hardware.opengl = {
           driSupport = true;
           driSupport32Bit = true;
       };
       # systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
       # hardware.opengl.extraPackages = [ 
       #   pkgs.rocmPackages.clr.icd 
       #   pkgs.amdvlk 
       # ];
       services.udev.extraRules = ''
# MINDSTORMS NXT brick 
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0002", MODE="666", TAG+="uaccess"
# MINDSTORMS NXT brick in firmware update mode (Atmel SAM-BA mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE="666", TAG+="uaccess"
# MINDSTORMS EV3 brick
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0005", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0005", MODE="666", TAG+="uaccess"
# MINDSTORMS EV3 brick in firmware update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0006", MODE="666", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0006", MODE="666", TAG+="uaccess"
# SPIKE Prime hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0008", MODE="666", TAG+="uaccess"
# SPIKE Prime hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0009", MODE="666", TAG+="uaccess"
# SPIKE Essential hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="000c", MODE="666", TAG+="uaccess"
# SPIKE Essential hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="000d", MODE="666", TAG+="uaccess"
# MINDSTORMS Inventor hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0010", MODE="666", TAG+="uaccess"
# MINDSTORMS Inventor hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0011", MODE="666", TAG+="uaccess"
  '';
  };
}
