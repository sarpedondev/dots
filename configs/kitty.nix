{ config, pkgs, ... }: {
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "RobotoMono Nerd Font";
      size = 11.0;
    };
    settings = {
      window_padding_width = 15;
      hide_window_decorations = true;
      allow_remote_control = true;
      confirm_os_window_close = 0;
    };
  };
}
