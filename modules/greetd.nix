{ pkgs, config, ... }:
let
  uwsmOnlySessions = pkgs.linkFarm "wayland-sessions-uwsm-only" [
    {
      name = "share/wayland-sessions/hyprland-uwsm.desktop";
      path = "${config.programs.hyprland.package}/share/wayland-sessions/hyprland-uwsm.desktop";
    }
  ];
in
{
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings.default_session = {
      user = "greeter";
      command = "${pkgs.tuigreet}/bin/tuigreet -r --sessions ${uwsmOnlySessions}/share/wayland-sessions";
    };
  };
}
