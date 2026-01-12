{
  home-manager.users.tom = {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "sarpedon";
          email = "sarpedon.dev@gmail.com";
        };
        gpg.format = "ssh";
        gpg."ssh".program = "/run/current-system/sw/bin/op-ssh-sign";
        url."git@github.com:".insteadOf = "https://github.com/";
      };
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhIFHH0pnLAj8O8KZ/N9U6DVy2ROPKeDECho0S3OXYP";
        signByDefault = true;
      };
    };
  };
}
