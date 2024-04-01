{ pkgs, config, lib, ... }:
{
  users.users.tom = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
