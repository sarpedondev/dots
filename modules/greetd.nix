{ pkgs, config, ... }:
{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet -r"; # --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
        user = "greeter";
      };
    };
  };
}
