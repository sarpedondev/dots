{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    userName = "TomJuri";
    userEmail = "mail@tomjuri.de";
    signing = {
      key = "324DE11EA057A78F";
      signByDefault = true;
    };
  };
}
