{ inputs, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules
    ../../modules/disable-nvidia.nix
    {
      home-manager.users.tom = {
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs.sops-nix.homeManagerModules.sops
        ];
      };

      nixpkgs.overlays = overlays;

      networking.hostName = "xenon";

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "ehci_pci"
        "ahci"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "rtsx_pci_sdmmc"
      ];
      boot.kernelModules = [ "kvm-intel" ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/6d06d702-bbb8-4cda-b415-a9e0864db3da";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/3E4A-9648";
        fsType = "vfat";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/b5f5f1ed-b2a6-4bf7-b504-23e380f03557"; }
      ];

      nixpkgs.hostPlatform = inputs.nixpkgs.lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = true;
      hardware.enableRedistributableFirmware = true;

      hyprland = {
        enable = true;
        monitor = "LVDS-1,1366x768@60,0x0,1";
      };

      hyprpaper = {
        enable = true;
        monitor = "LVDS-1";
        wallpaper = "${./.}/wallpaper.jpg";
      };

      programs.dconf.enable = true;

      kitty.enable = true;
      rofi.enable = true;
      sddm.enable = true;
      waybar.enable = true;

      docker.enable = true;
      git.enable = true;
      java.enable = true;

      audio.enable = true;
      bluetooth.enable = true;
      plymouth.enable = true;
    }
  ];
}
