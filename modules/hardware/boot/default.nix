{ config, lib, ... }:
{
  options = {
    plymouth.enable = lib.mkEnableOption "Enables plymouth";
  };

  config = {
    boot.kernelParams = [
      "quiet"
      "splash"
    ];
    boot.supportedFilesystems = [ "ntfs" ];

    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.kernelModules = [ "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';

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
