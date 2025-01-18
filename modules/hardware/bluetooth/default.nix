{ pkgs, config, lib, ... }: {
  options = { bluetooth.enable = lib.mkEnableOption "Enables bluetooth"; };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    home-manager.users.tom.services.blueman-applet.enable = true;
    services.blueman.enable = true;
  };
}
