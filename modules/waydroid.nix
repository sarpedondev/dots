{ pkgs, ... }:
{
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  programs.wireshark.enable = true;
  users.users.tom.extraGroups = [ "wireshark" ];

  security.sudo.extraRules = [
    {
      users = [ "tom" ];
      commands = [
        {
          command = "/run/current-system/sw/bin/waydroid shell";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/waydroid shell *";
          options = [ "NOPASSWD" ];
        }
        {
          command = "/run/current-system/sw/bin/systemctl restart waydroid-container";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}
