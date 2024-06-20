{ pkgs, config, lib, ... }: 
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
          key = "C3AB37F1B4E02425";
          signByDefault = true;
        };
      };
      programs.gpg = {
        enable = true;

      };
      services.gpg-agent.enable = true;
    };
  };
}
