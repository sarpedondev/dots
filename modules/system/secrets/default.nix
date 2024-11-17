{ pkgs, ... }:
{
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tom" ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/etc/age-key";
    secrets = {
      "gpg/public" = {};
      "gpg/private" = {     mode = "0400"; path = "/home/tom/.gnupg/private-keys-v1.d/C3AB37F1B4E02425.key"; };
      password = { neededForUsers = true; };
    };
  };

  security.polkit.enable = true;
  home-manager.users.tom = {
    services.gnome-keyring.enable = true;
    programs.ssh = {
      enable = true;
      extraConfig = ''
        Host *
            IdentityAgent ~/.1password/agent.sock
      '';
    };
    home.packages = with pkgs; [
      sops
    ];
  };
}
