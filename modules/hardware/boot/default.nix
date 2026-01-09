{ config, lib, ... }: {
  options = { plymouth.enable = lib.mkEnableOption "Enables plymouth"; };

  config = {
    boot.kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
    boot.supportedFilesystems = [ "ntfs" ];

    boot.plymouth.enable = config.plymouth.enable;

    boot.loader = {
      timeout = 3;
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
