{ pkgs, config, lib, ... }:
{
  options = {
    sddm.enable = lib.mkEnableOption "Enables sddm";
  };

  config = lib.mkIf config.sddm.enable {
    services = {
      xserver.enable = true;
      displayManager = {
        sessionPackages = [ pkgs.hyprland ];
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "catppuccin-mocha";
        };
      };
    };
    environment.systemPackages = [
      pkgs.nur.repos.MtFBella109.catppuccin-mocha 
    ];
  };
}
