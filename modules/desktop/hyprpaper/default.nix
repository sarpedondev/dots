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
            
            
            vesktop
            grimblast
          vlc
            firefox
            gedit
            gimp
            spotify
            davinci-resolve
            gnome.nautilus
            gnome.sushi
           gnome.totem
            jetbrains.pycharm-professional
            jetbrains.idea-ultimate
            jetbrains.clion
            android-studio
            docker-compose
            libsForQt5.polkit-kde-agent
            github-copilot-intellij-agent
            prismlauncher
            unrar
           unzip
      ];
      xdg.configFile."hypr/hyprpaper.conf".text = ''
        preload = ${config.hyprpaper.wallpaper}
      wallpaper = ${config.hyprpaper.monitor},${config.hyprpaper.wallpaper}
      '';
    };
            # HIP, ROCM and OpenGL
        hardware.opengl.enable = true;
        systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
        hardware.opengl.extraPackages = [ 
          pkgs.rocmPackages.clr.icd 
          pkgs.amdvlk 
        ];
  };
}
