{ pkgs, ... }:
{
  programs._1password-gui.enable = true;
  home-manager.users.tom = {
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
