{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.default
    ../../modules
    ./disks/nvme.nix
  ];
  users.users.tom = {
    isNormalUser = true;
    description = "Me";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    password = "1234";
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", MODE="0666"
  '';

  wallpaper = {
    path = "${./.}/wallpaper.png";
    monitor = "eDP-1";
  };

  monitors = [
    "eDP-1,2560x1600@165,0x0,1.25"
    #"eDP-1,1920x1080@165,0x0,1"
    "DP-4,1920x1080@60,0x0,1,mirror,eDP-1"
  ];

  nixpkgs.config.allowUnfree = true;

  theme = {
    enable = true;
    palette = {
      # Backgrounds
      bg0 = "#0f0c0a";
      bg1 = "#17110e";
      bg2 = "#1f1713";
      bg3 = "#2a1e18";

      # Foregrounds
      fg0 = "#f3ebe6";
      fg1 = "#e5d6cd";
      fg2 = "#cbb8ad";
      comment = "#9a847a";

      # Accents
      accent0 = "#f6a06a";
      accent1 = "#f7b38a";
      accent2 = "#f4c1a3";
      accent3 = "#e9c7a7";

      # Semantic
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

      # UI utility
      border = "#3a2a22";
      shadow = "#070504";
      selection = "#3b2a22";
      cursor = "#f7b38a";
    };
  };

  home-manager.users.tom = {
    programs.kitty.enable = true;
    home.stateVersion = "26.05";
  };

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "-d";
    };
  };
  console.keyMap = "de";
  networking.hostName = "helium";
  networking.networkmanager.enable = true;
  system.stateVersion = "26.05";

  programs.dconf.enable = true;
  services.fwupd.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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
        theme = "${pkgs.sleek-grub-theme.override { withStyle = "orange"; }}";
      };
      efi.canTouchEfiVariables = true;
    };
  };

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
