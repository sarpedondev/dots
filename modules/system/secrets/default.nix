{ pkgs, ... }:
{
  programs.ssh = {
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock

      Host ssh.nebulaclient.net
        ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
      Host xenon
        Hostname 192.168.178.131
    '';
  };

  environment.systemPackages = with pkgs; [ cloudflared ];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tom" ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/etc/age-key";
    secrets = {
      password = {
        neededForUsers = true;
      };
      "k3s/secrets/shkeeper/bitcoin-rpc/username" = { };
      "k3s/secrets/shkeeper/bitcoin-rpc/password" = { };
      "k3s/secrets/shkeeper/litecoin-rpc/username" = { };
      "k3s/secrets/shkeeper/litecoin-rpc/password" = { };
    };
  };

  environment.variables.SOPS_AGE_KEY_FILE = "/etc/age-key";

  security.polkit.enable = true;
  home-manager.users.tom = {
    services.gnome-keyring.enable = true;

    home = {
      packages = with pkgs; [
        sops
        gcr
      ];
      sessionVariables = {
        SSH_AUTH_SOCK = "/home/tom/.1password/agent.sock";
      };
    };
  };
}
