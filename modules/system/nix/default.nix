{ pkgs, config, lib, ... }: 
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
  home-manager.users.tom = {
    home.username = "tom";
    home.homeDirectory = "/home/tom";
    home.stateVersion = "23.11";
  };
}
