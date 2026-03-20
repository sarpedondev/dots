{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    ../../modules
    ./disks/nvme.nix
    ./disks/ssd.nix
  ]
  ++ [
    ../../optional/openrgb.nix
    ../../optional/noisetorch.nix
  ];

  networking.hostName = "neon";
  system.stateVersion = "26.05";
  home-manager.users.tom.home.stateVersion = "26.05";

  monitors = [ "DP-1,5120x1440@120,0x0,1" ];
  wallpaper = {
    path = "${./.}/wallpaper.jpg";
    monitor = "DP-1";
  };

  theme = {
    enable = true;
    palette = {
      bg0 = "#11111b";
      bg1 = "#181825";
      bg2 = "#1e1e2e";
      bg3 = "#313244";

      fg0 = "#cdd6f4";
      fg1 = "#bac2de";
      fg2 = "#a6adc8";
      comment = "#7f849c";

      accent0 = "#cba6f7";
      accent1 = "#b4befe";
      accent2 = "#f5c2e7";
      accent3 = "#f5e0dc";

      red = "#f38ba8";
      orange = "#fab387";
      yellow = "#f9e2af";
      green = "#a6e3a1";
      cyan = "#89dceb";
      blue = "#89b4fa";
      purple = "#b4befe";
      magenta = "#f5c2e7";
      teal = "#94e2d5";
      brown = "#eba0ac";

      border = "#6c7086";
      shadow = "#11111b";
      selection = "#585b70";
      cursor = "#cba6f7";
    };
  };

  hardware = {
    amdgpu.opencl.enable = true;
    cpu.amd.updateMicrocode = true;
  };

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
}
