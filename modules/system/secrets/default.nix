{ pkgs, ... }:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      sops
    ];
    sops = {
      defaultSopsFile = ./secrets.yaml;
      age.keyFile = "/home/tom/.config/sops/age/keys.txt";
      secrets = {
        "gpg/public" = {};
        "gpg/private" = {};
      };
    };
  };
}
