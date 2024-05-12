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
  };
}
