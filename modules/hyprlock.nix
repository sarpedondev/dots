{
  home-manager.users.tom.programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
        text_trim = true;
      };

      background = [
        {
          monitor = "";
          path = "screenshot";

          blur_passes = 3;
          blur_size = 8;

          noise = 2.0e-2;
          brightness = 0.85;
          contrast = 0.9;
        }
      ];

      label = [
        {
          text = "Welcome back, $USER";
          color = "rgba(205, 214, 244, 1)"; # #cdd6f4 (text)
          font_size = 18;
          font_family = "0xProto Nerd Font";
          position = "0, 0";
          halign = "center";
          valign = "center";
        }
      ];

      input-field = [
        {
          size = "420, 64";
          position = "0, -40";

          rounding = 16;
          outline_thickness = 4;

          outer_color = "rgba(203, 166, 247, 1)"; # #cba6f7 (mauve)
          inner_color = "rgba(30, 30, 46, 1)"; # #1e1e2e (base)
          font_color = "rgba(205, 214, 244, 1)"; # #cdd6f4 (text)

          check_color = "rgba(180, 190, 254, 1)"; # #b4befe (lavender)
          fail_color = "rgba(243, 139, 168, 1)"; # #f38ba8 (red)

          fade_on_empty = false;
          placeholder_text = "<span foreground='##bac2de'><i>password…</i></span>";

          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
