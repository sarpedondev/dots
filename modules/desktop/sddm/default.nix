{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    sddm.enable = lib.mkEnableOption "Enables sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services = {
      xserver = {
        enable = true;
        excludePackages = [ pkgs.xterm ];
      };
      displayManager = {
        sessionPackages = [ pkgs.hyprland ];
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "catppuccin-mocha-mauve";
        };
      };
    };
    environment.systemPackages = with pkgs; [ catppuccin-sddm ];
  };
}
