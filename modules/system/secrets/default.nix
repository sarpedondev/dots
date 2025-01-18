{ pkgs, ... }: {
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "tom" ];
  };

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/etc/age-key";
    secrets = { password = { neededForUsers = true; }; };
  };

  environment.variables.SOPS_AGE_KEY_FILE = "/etc/age-key";

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
    home = {
      packages = with pkgs; [ sops gcr ];
      sessionVariables = { SSH_AUTH_SOCK = "/home/tom/.1password/agent.sock"; };
    };
  };
}
