{ pkgs, config, lib, ... }: {
  options = { waybar.enable = lib.mkEnableOption "Enables waybar"; };

  config = lib.mkIf config.waybar.enable {
    home-manager.users.tom = {
      programs.waybar = {
        enable = true;
        settings = [{
          layer = "top";
          position = "bottom";
          mod = "dock";
          height = 31;
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;

          modules-left = [
            "custom/padd"
            "custom/l_end"
            "custom/power"
            "custom/cliphist"
            "custom/picker"
            "custom/r_end"
            "custom/l_end"
            "wlr/taskbar"
            "custom/r_end"
            "custom/padd"
          ];
          modules-center = [
            "custom/padd"
            "custom/l_end"
            "clock"
            "custom/r_end"
            "custom/padd"
          ];
          modules-right = [
            "custom/padd"
            "custom/l_end"
            "tray"
            "custom/r_end"
            "custom/l_end"
            "network"
            "pulseaudio"
            "pulseaudio#microphone"
            "custom/r_end"
            "custom/padd"
          ];

          "custom/power" = {
            format = "{}";
            exec = "echo ; echo  logout";
            on-click = "~/.config/hypr/scripts/logoutlaunch.sh 2";
            interval = 86400;
            tooltip = true;
          };

          "custom/cliphist" = {
            format = "";
            exec = "echo ; echo 󰅇 clipboard history";
            on-click = "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh c";
            on-click-right =
              "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh d";
            on-click-middle =
              "sleep 0.1 && ~/.config/hypr/scripts/cliphist.sh w";
            interval = 86400;
            tooltip = true;
          };

          "custom/picker" = {
            format = "";
            exec = "echo ; echo  color picker";
            on-click = "hyprpicker -a -f hex -r";
            on-click-right = "hyprpicker -a -f rgb -r";
            interval = 86400;
            tooltip = true;
          };

          "wlr/taskbar" = {
            format = "{icon}";
            icon-size = 18;
            icon-theme = "Tela-circle-dracula";
            spacing = 0;
            tooltip-format = "{title}";
            on-click = "activate";
            on-click-middle = "close";
          };

          clock = {
            format = "{: %R}";
            format-alt = "{:󰃭 %d·%m·%y}";
            tooltip-format = "<tt>{calendar}</tt>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };

          tray = {
            icon-size = 18;
            spacing = 5;
          };

          network = {
            format-ethernet = "󱘖 Wired";
            tooltip-format =
              "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
            format-linked = "󱘖 {ifname} (No IP)";
            format-disconnected = " Disconnected";
          };

          pulseaudio = {
            format = "{icon} {volume}";
            format-muted = "󰟎 0";
            on-click = "pavucontrol -t 3";
            on-click-middle = "~/.config/hypr/scripts/volumecontrol.sh -o m";
            on-scroll-up = "~/.config/hypr/scripts/volumecontrol.sh -o i";
            on-scroll-down = "~/.config/hypr/scripts/volumecontrol.sh -o d";
            tooltip-format = "{icon} {desc} // {volume}%";
            scroll-step = 5;
            format-icons = { headset = "󰋋"; };
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            format-source = " {volume}";
            format-source-muted = " 0";
            on-click = "pavucontrol -t 4";
            on-click-middle = "~/.config/hypr/scripts/volumecontrol.sh -i m";
            on-scroll-up = "~/.config/hypr/scripts/volumecontrol.sh -i i";
            on-scroll-down = "~/.config/hypr/scripts/volumecontrol.sh -i d";
            tooltip-format =
              "{format_source} {source_desc} // {source_volume}%";
            scroll-step = 5;
          };

          "custom/l_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/r_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/sl_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/sr_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/rl_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/rr_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/padd" = {
            format = "  ";
            interval = "once";
            tooltip = false;
          };
        }];

        style = ''
                  * {
          border: none;
                  border-radius: 0px;
                  font-family: NotoSerif Nerd Font;
                  font-weight: bold;
                  font-size: 12px;
                  min-height: 10px;
                  }

                @define-color bar-bg rgba(0, 0, 0, 0);

                @define-color main-bg #11111b;
                @define-color main-fg #cdd6f4;

                @define-color wb-act-bg #a6adc8;
                @define-color wb-act-fg #313244;

                @define-color wb-hvr-bg #f5c2e7;
                @define-color wb-hvr-fg #313244;

                window#waybar {
          background: @bar-bg;
                }

                tooltip {
          background: @main-bg;
          color: @main-fg;
                 border-radius: 8px;
                 border-width: 0px;
                }

          #workspaces button {
            box-shadow: none;
            text-shadow: none;
          padding: 0px;
                   border-radius: 9px;
                   margin-top: 3px;
                   margin-bottom: 3px;
                   padding-left: 3px;
                   padding-right: 3px;
          color: @main-fg;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #workspaces button.active {
          background: @wb-act-bg;
          color: @wb-act-fg;
                 margin-left: 3px;
                 padding-left: 12px;
                 padding-right: 12px;
                 margin-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #workspaces button:hover {
          background: @wb-hvr-bg;
          color: @wb-hvr-fg;
                 padding-left: 3px;
                 padding-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #taskbar button {
            box-shadow: none;
            text-shadow: none;
          padding: 0px;
                   border-radius: 9px;
                   margin-top: 3px;
                   margin-bottom: 3px;
                   padding-left: 3px;
                   padding-right: 3px;
          color: @wb-color;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.5s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #taskbar button.active {
          background: @wb-act-bg;
          color: @wb-act-color;
                 margin-left: 3px;
                 padding-left: 12px;
                 padding-right: 12px;
                 margin-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #taskbar button:hover {
          background: @wb-hvr-bg;
          color: @wb-hvr-color;
                 padding-left: 3px;
                 padding-right: 3px;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
          }

          #backlight,
          #battery,
          #bluetooth,
          #custom-cliphist,
          #custom-picker,
          #clock,
          #cpu,
          #custom-gpuinfo,
          #idle_inhibitor,
          #language,
          #memory,
          #custom-mode,
          #mpris,
          #network,
          #custom-power,
          #pulseaudio,
          #custom-spotify,
          #taskbar,
          #tray,
          #custom-updates,
          #custom-wallchange,
          #custom-wbar,
          #window,
          #workspaces,
          #custom-l_end,
          #custom-r_end,
          #custom-sl_end,
          #custom-sr_end,
          #custom-rl_end,
          #custom-rr_end {
          color: @main-fg;
          background: @main-bg;
          opacity: 1;
          margin: 4px 0px 4px 0px;
                  padding-left: 4px;
                  padding-right: 4px;
          }

          #workspaces,
          #taskbar {
          padding: 0px;
          }

          #custom-r_end {
            border-radius: 0px 22px 22px 0px;
            margin-right: 9px;
            padding-right: 3px;
          }

          #custom-l_end {
            border-radius: 22px 0px 0px 22px;
            margin-left: 9px;
            padding-left: 3px;
          }

          #custom-sr_end {
            border-radius: 0px;
            margin-right: 9px;
            padding-right: 3px;
          }

          #custom-sl_end {
            border-radius: 0px;
            margin-left: 9px;
            padding-left: 3px;
          }      

          #custom-rr_end {
            border-radius: 0px 8px 8px 0px;
            margin-right: 9px;
            padding-right: 3px;
          }

          #custom-rl_end {
            border-radius: 8px 0px 0px 8px;
            margin-left: 9px;
            padding-left: 3px;
          }
        '';
      };
    };
  };
}
