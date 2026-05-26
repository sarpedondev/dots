{ lib, config, ... }:

let
  lua = lib.generators.mkLuaInline;

  bind = key: dispatcher: {
    _args = [
      key
      (lua dispatcher)
    ];
  };

  bindWithFlags = key: dispatcher: flags: {
    _args = [
      key
      (lua dispatcher)
      flags
    ];
  };
in
{
  options = {
    monitors = lib.mkOption {
      type = lib.types.listOf lib.types.attrs;
      default = [ ];
    };
  };

  config = {
    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    home-manager.users.tom = {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "lua";
        systemd.enable = false;

        settings = {
          on = {
            _args = [
              "hyprland.start"
              (lua ''
                function()
                  hl.exec_cmd("waybar")
                  hl.exec_cmd("hyprlauncher -d")
                  hl.exec_cmd("1password --silent")
                end
              '')
            ];
          };

          bind = [
            (bind "SUPER + Q" "hl.dsp.window.close()")
            (bind "SUPER + W" ''hl.dsp.window.float({ action = "toggle" })'')
            (bind "ALT + space" ''hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" })'')
            (bind "SUPER + T" ''hl.dsp.exec_cmd("kitty")'')
            (bind "Print" ''hl.dsp.exec_cmd("grimblast --freeze copy area")'')
            (bind "SUPER + SHIFT + S" ''hl.dsp.exec_cmd("grimblast --notify --freeze --filetype png copysave area \"/home/tom/Pictures/Screenshots/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png\"")'')
            (bind "SUPER + V" ''hl.dsp.exec_cmd("pkill -x rofi || TODO clipboard")'')
            (bind "SUPER + left" ''hl.dsp.focus({ direction = "l" })'')
            (bind "SUPER + right" ''hl.dsp.focus({ direction = "r" })'')
            (bind "SUPER + up" ''hl.dsp.focus({ direction = "u" })'')
            (bind "SUPER + down" ''hl.dsp.focus({ direction = "d" })'')
            (bind "SUPER + 1" "hl.dsp.focus({ workspace = 1 })")
            (bind "SUPER + 2" "hl.dsp.focus({ workspace = 2 })")
            (bind "SUPER + 3" "hl.dsp.focus({ workspace = 3 })")
            (bind "SUPER + 4" "hl.dsp.focus({ workspace = 4 })")
            (bind "SUPER + SHIFT + 1" "hl.dsp.window.move({ workspace = 1 })")
            (bind "SUPER + SHIFT + 2" "hl.dsp.window.move({ workspace = 2 })")
            (bind "SUPER + SHIFT + 3" "hl.dsp.window.move({ workspace = 3 })")
            (bind "SUPER + SHIFT + 4" "hl.dsp.window.move({ workspace = 4 })")
            (bindWithFlags "SUPER + SUPER_L" ''hl.dsp.exec_cmd("hyprlauncher")'' {
              release = true;
            })
            (bindWithFlags "SUPER + mouse:272" "hl.dsp.window.drag()" {
              mouse = true;
            })
            (bindWithFlags "SUPER + mouse:273" "hl.dsp.window.resize()" {
              mouse = true;
            })
          ];

          monitor = config.monitors;

          curve = [
            {
              _args = [
                "wind"
                {
                  type = "bezier";
                  points = [
                    [
                      0.05
                      0.9
                    ]
                    [
                      0.1
                      1.05
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "winIn"
                {
                  type = "bezier";
                  points = [
                    [
                      0.1
                      1.1
                    ]
                    [
                      0.1
                      1.1
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "winOut"
                {
                  type = "bezier";
                  points = [
                    [
                      0.3
                      (-0.3)
                    ]
                    [
                      0
                      1
                    ]
                  ];
                }
              ];
            }
            {
              _args = [
                "liner"
                {
                  type = "bezier";
                  points = [
                    [
                      1
                      1
                    ]
                    [
                      1
                      1
                    ]
                  ];
                }
              ];
            }
          ];

          animation = [
            {
              leaf = "windows";
              enabled = true;
              speed = 6;
              bezier = "wind";
              style = "slide";
            }
            {
              leaf = "windowsIn";
              enabled = true;
              speed = 6;
              bezier = "winIn";
              style = "slide";
            }
            {
              leaf = "windowsOut";
              enabled = true;
              speed = 5;
              bezier = "winOut";
              style = "slide";
            }
            {
              leaf = "windowsMove";
              enabled = true;
              speed = 5;
              bezier = "wind";
              style = "slide";
            }
            {
              leaf = "border";
              enabled = true;
              speed = 1;
              bezier = "liner";
            }
            {
              leaf = "borderangle";
              enabled = true;
              speed = 30;
              bezier = "liner";
              style = "loop";
            }
            {
              leaf = "fade";
              enabled = true;
              speed = 10;
              bezier = "default";
            }
            {
              leaf = "workspaces";
              enabled = true;
              speed = 5;
              bezier = "wind";
            }
          ];

          config = {
            general = {
              gaps_in = 3;
              gaps_out = 8;
              border_size = 2;

              "col.active_border" = {
                colors = [
                  "#${lib.removePrefix "#" config.theme.colors.accent0.hex}ff"
                  "#${lib.removePrefix "#" config.theme.colors.accent1.hex}ff"
                ];
                angle = 45;
              };

              "col.inactive_border" = {
                colors = [
                  "#${lib.removePrefix "#" config.theme.colors.border.hex}cc"
                  "#${lib.removePrefix "#" config.theme.colors.bg2.hex}cc"
                ];
                angle = 45;
              };

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

            animations = {
              enabled = true;
            };

            input = {
              kb_layout = "de";

              touchpad = {
                natural_scroll = true;
                disable_while_typing = false;
              };
            };

            misc = {
              force_default_wallpaper = 0;
              disable_hyprland_logo = true;
            };

            xwayland = {
              force_zero_scaling = true;
            };
          };

          window_rule = {
            name = "fixintellij";
            match.class = "jetbrains-idea";
            no_initial_focus = true;
          };
        };
      };
    };
  };
}
