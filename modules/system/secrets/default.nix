{ pkgs, ... }:
{
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tom" ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/home/tom/.config/sops/age/keys.txt";
    secrets = {
      "gpg/public" = {};
      "gpg/private" = {     mode = "0400"; path = "/home/tom/.gnupg/private-keys-v1.d/tom.key"; };
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
