{
  programs.ssh = {
    extraConfig = ''
      IdentityAgent ~/.1password/agent.sock
    '';
  };

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
