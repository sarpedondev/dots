{ pkgs, ... }:
{
  virtualisation.docker.enable = true;
  users.users.tom.extraGroups = [ "docker" ];
  home-manager.users.tom = {
    home.packages = with pkgs; [ docker-compose ];
  };
}
