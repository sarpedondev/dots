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

  environment.etc."1password/custom_allowed_browsers" = {
    text = "librewolf";
    mode = "0755";
  };

  security.pam.services.login.enableGnomeKeyring = true;

  security.polkit.enable = true;
  home-manager.users.tom = {
    home = {
      packages = with pkgs; [ gcr ];
      sessionVariables = {
        SSH_AUTH_SOCK = "/home/tom/.1password/agent.sock";
      };
    };
    services.gnome-keyring.enable = true;
  };
}
