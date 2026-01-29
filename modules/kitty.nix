{ config, ... }:
{
  home-manager.users.tom = {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      font = {
        name = "NotoSansM Nerd Font";
        size = 11.0;
      };
      settings = {
        window_padding_width = 15;
        hide_window_decorations = true;
        allow_remote_control = true;
        confirm_os_window_close = 0;
      };
      extraConfig = ''
        foreground              ${config.theme.colors.fg0.hex}
        background              ${config.theme.colors.bg1.hex}
        selection_foreground    ${config.theme.colors.bg1.hex}
        selection_background    ${config.theme.colors.selection.hex}

        cursor                  ${config.theme.colors.cursor.hex}
        cursor_text_color       ${config.theme.colors.bg1.hex}

        url_color               ${config.theme.colors.accent3.hex}

        active_border_color     ${config.theme.colors.accent1.hex}
        inactive_border_color   ${config.theme.colors.border.hex}
        bell_border_color       ${config.theme.colors.yellow.hex}

        wayland_titlebar_color system
        macos_titlebar_color system

        active_tab_foreground   ${config.theme.colors.bg0.hex}
        active_tab_background   ${config.theme.colors.accent0.hex}
        inactive_tab_foreground ${config.theme.colors.fg0.hex}
        inactive_tab_background ${config.theme.colors.bg2.hex}
        tab_bar_background      ${config.theme.colors.bg0.hex}

        mark1_foreground ${config.theme.colors.bg1.hex}
        mark1_background ${config.theme.colors.accent1.hex}
        mark2_foreground ${config.theme.colors.bg1.hex}
        mark2_background ${config.theme.colors.accent0.hex}
        mark3_foreground ${config.theme.colors.bg1.hex}
        mark3_background ${config.theme.colors.cyan.hex}

        color0  ${config.theme.colors.bg3.hex}
        color8  ${config.theme.colors.border.hex}

        color1  ${config.theme.colors.red.hex}
        color9  ${config.theme.colors.red.hex}

        color2  ${config.theme.colors.green.hex}
        color10 ${config.theme.colors.green.hex}

        color3  ${config.theme.colors.yellow.hex}
        color11 ${config.theme.colors.yellow.hex}

        color4  ${config.theme.colors.blue.hex}
        color12 ${config.theme.colors.blue.hex}

        color5  ${config.theme.colors.magenta.hex}
        color13 ${config.theme.colors.magenta.hex}

        color6  ${config.theme.colors.teal.hex}
        color14 ${config.theme.colors.teal.hex}

        color7  ${config.theme.colors.fg1.hex}
        color15 ${config.theme.colors.fg2.hex}
      '';
    };
    home.sessionVariables = {
      TERM = "kitty";
      TERMINAL = "kitty";
    };
  };
}
