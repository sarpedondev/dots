{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    git.enable = lib.mkEnableOption "Enables git";
  };

  config = lib.mkIf config.git.enable {
    home-manager.users.tom = {
      programs.git = {
        enable = true;
        userName = "Tom";
        userEmail = "mail@tomjuri.de";
        signing = {
          key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAhIFHH0pnLAj8O8KZ/N9U6DVy2ROPKeDECho0S3OXYP";
          signByDefault = true;
        };
        extraConfig = {
          gpg.format = "ssh";
          gpg."ssh".program = "/run/current-system/sw/bin/op-ssh-sign";
          url."git@github.com:".insteadOf = "https://github.com/";
        };
      };
    };
  };
}
