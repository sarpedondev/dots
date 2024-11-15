{ inputs, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux"; 
  modules = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    ./disks.nix
    inputs.impermanence.nixosModules.impermanence
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


      boot.initrd.postDeviceCommands = inputs.nixpkgs.lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
      '';

      fileSystems."/persist".neededForBoot = true;
      environment.persistence."/persist" = {
        hideMounts = true;
        directories = [
          "/etc/nixos"
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
          { directory = "/var/lib/colord"; user = "colord"; group = "colord"; mode = "u=rwx,g=rx,o="; }
        ];
        files = [
          "/etc/machine-id"
          { file = "/var/keys/secret_file"; parentDirectory = { mode = "u=rwx,g=,o="; }; }
        ];
        users.tom = {
          directories = [
            "Downloads"
            "dots"
            ".config/1Password"
            ".config/sops"
          ];
        };

      };

      programs.fuse.userAllowOther = true;
    }
  ];
}
