{ pkgs, config, lib, ... }:
{
  options = {
    plymouth.enable = lib.mkEnableOption "Enables plymouth";
  };

  config = {
    boot.kernelParams = [ "quiet" "splash" ];
    boot.supportedFilesystems = [ "ntfs" ];

    boot.plymouth.enable = config.plymouth.enable;
  
    boot.loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
  };
}
