{ lib, config, ... }:
{
  options = {
    monitor = lib.mkOption { type = lib.types.str; };
  };
  config = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };
    home-manager.users.tom = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        settings = {
          exec-once = [
            "waybar"
            "hyprlauncher -d"
          ];
          bind = [
            "SUPER, Q, exec, hyprctl dispatch killactive"
            "SUPER, W, togglefloating"
            "ALT, space, fullscreen"
            "SUPER, T, exec, kitty"
            ", print, exec, grimblast copy area --freeze"
            "SUPER, V, exec, pkill -x rofi || TODO clipboard"
            "SUPER, left, movefocus, l"
            "SUPER, right, movefocus, r"
            "SUPER, up, movefocus, u"
            "SUPER, down, movefocus, d"
            "SUPER, 1, workspace, 1"
            "SUPER, 2, workspace, 2"
            "SUPER, 3, workspace, 3"
            "SUPER, 4, workspace, 4"
            "SUPER SHIFT, 1, movetoworkspace, 1"
            "SUPER SHIFT, 2, movetoworkspace, 2"
            "SUPER SHIFT, 3, movetoworkspace, 3"
            "SUPER SHIFT, 4, movetoworkspace, 4"
          ];

          bindr = [ "SUPER, SUPER_L, exec, hyprlauncher" ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          monitor = config.monitor;
          #monitor = "";
          #= [
          #           "HDMI-A-1,1366x768@60,0x0,1,mirror,LVDS-1"
          #        ];

          general = {
            gaps_in = 3;
            gaps_out = 8;
            border_size = 2;
            "col.active_border" = "rgba(ca9ee6ff) rgba(f2d5cfff) 45deg";
            "col.inactive_border" = "rgba(b4befecc) rgba(6c7086cc) 45deg";
            layout = "dwindle";
            resize_on_border = true;
          };

          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 6;
              passes = 3;
              new_optimizations = true;
              ignore_opacity = true;
              xray = false;
            };
          };

          windowrulev2 = [
            "noinitialfocus,class:^jetbrains-(?!toolbox),floating:1"
            "noinitialfocus,class:^1Password,floating:1"
            "noblur,title:RedTide"
          ];

          animations = {
            enabled = true;
            bezier = [
              "wind, 0.05, 0.9, 0.1, 1.05"
              "winIn, 0.1, 1.1, 0.1, 1.1"
              "winOut, 0.3, -0.3, 0, 1"
              "liner, 1, 1, 1, 1"
            ];
            animation = [
              "windows, 1, 6, wind, slide"
              "windowsIn, 1, 6, winIn, slide"
              "windowsOut, 1, 5, winOut, slide"
              "windowsMove, 1, 5, wind, slide"
              "border, 1, 1, liner"
              "borderangle, 1, 30, liner, loop"
              "fade, 1, 10, default"
              "workspaces, 1, 5, wind"
            ];
          };

          input = {
            kb_layout = "de";
            touchpad = {
              natural_scroll = true;
            };
          };

          misc = {
            force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
          };
        };
      };
    };
  };
}
