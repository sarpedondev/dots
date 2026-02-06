{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    ../../modules
    ./disks/nvme.nix
  ];

  networking.hostName = "helium";
  system.stateVersion = "26.05";
  home-manager.users.tom.home.stateVersion = "26.05";

  monitors = [
    "eDP-1,2560x1600@165,0x0,1.25"
    "DP-4,1920x1080@60,0x0,1,mirror,eDP-1"
  ];

  wallpaper = {
    path = "${./.}/wallpaper.png";
    monitor = "eDP-1";
  };

  theme = {
    enable = true;
    palette = {
      bg0 = "#0f0c0a";
      bg1 = "#17110e";
      bg2 = "#1f1713";
      bg3 = "#2a1e18";

      fg0 = "#f3ebe6";
      fg1 = "#e5d6cd";
      fg2 = "#cbb8ad";
      comment = "#9a847a";

      accent0 = "#f6a06a";
      accent1 = "#f7b38a";
      accent2 = "#f4c1a3";
      accent3 = "#e9c7a7";

      red = "#f28b82";
      orange = "#f6a06a";
      yellow = "#f2d28a";
      green = "#b8e3a6";
      cyan = "#9fe3e3";
      blue = "#a7c7ff";
      purple = "#d7b2ff";
      magenta = "#f2a7d7";
      teal = "#8fd3c8";
      brown = "#c9a38a";

      border = "#3a2a22";
      shadow = "#070504";
      selection = "#3b2a22";
      cursor = "#f7b38a";
    };
  };

  boot = {
    loader.grub.theme = "${pkgs.sleek-grub-theme.override { withStyle = "orange"; }}";
    initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "thunderbolt"
      "usbhid"
      "usb_storage"
      "sd_mod"
    ];
    kernelModules = [ "kvm-amd" ];
  };

  services.fwupd.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
}
