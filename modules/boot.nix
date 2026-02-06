{ pkgs, ... }:
{
  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
    plymouth.enable = true;
    loader = {
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
