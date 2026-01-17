{ pkgs, ... }:
{
  programs.ssh = {
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock

      Host ssh.nebulaclient.net
        ProxyCommand ${pkgs.cloudflared}/bin/cloudflared access ssh --hostname %h
    '';
  };

  environment.systemPackages = with pkgs; [ cloudflared ];

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tom" ];
  };

  security.polkit.enable = true;
  home-manager.users.tom = {
    home = {
      sessionVariables = {
        SSH_AUTH_SOCK = "/home/tom/.1password/agent.sock";
      };
    };
  };
}
