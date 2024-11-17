{ inputs, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    inputs.sops-nix.nixosModules.sops
    ./disks/nvme.nix
    ./disks/ssd.nix
    ../../modules
    {
      home-manager.users.tom = {
        imports = [
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };

      nixpkgs.overlays = overlays;

      networking.hostName = "neon";

      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      #boot.initrd.kernelModules = [ "amdgpu" ];
      boot.kernelModules = [ "kvm-amd" ];

      nixpkgs.hostPlatform = inputs.nixpkgs.lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = true;
      hardware.enableRedistributableFirmware = true;

      hyprland = {
        enable = true;
        monitor = "DP-1,5120x1440@120,0x0,1";
      };

      hyprpaper = {
        enable = true;
        monitor = "DP-1";
        wallpaper = "${./.}/wallpaper.jpg";
      };

      services.gvfs.enable = true;

      hardware.amd.gpu.enable = true;

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

      mullvad.enable = true;
    }
  ];
}
