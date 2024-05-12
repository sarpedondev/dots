{ inputs, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux"; 
  modules = [
    inputs.home-manager.nixosModules.home-manager
      ../../modules
      {

        home-manager.users.tom = {
          imports = [
            inputs.nixvim.homeManagerModules.nixvim
            inputs.sops-nix.homeManagerModules.sops
          ];
        };

        nixpkgs.overlays = overlays;

        networking.hostName = "neon";

        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
#boot.initrd.kernelModules = [ "amdgpu" ];
        boot.kernelModules = [ "kvm-amd" ];

        fileSystems."/" = { 
          device = "/dev/disk/by-uuid/545f1373-d113-49f8-bf1b-01cf45f7d2b8";
          fsType = "ext4";
        };

        fileSystems."/boot" = { 
          device = "/dev/disk/by-uuid/A3A3-D712";
          fsType = "vfat";
        };

        swapDevices = [ 
        { device = "/dev/disk/by-uuid/c79ff706-3ef0-41bb-beb1-a69c5eb42120"; }
        ];

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
