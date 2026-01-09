{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    mullvad.enable = lib.mkEnableOption "Enables mullvad";
  };
  config = lib.mkIf config.mullvad.enable {
    networking.wireguard.enable = true;
    services.resolved.enable = true;
    services.mullvad-vpn.enable = true;
    services.mullvad-vpn.package = pkgs.mullvad-vpn;
  };
}
