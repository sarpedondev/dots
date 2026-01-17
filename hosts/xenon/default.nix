{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules
    ./hardware-configuration.nix
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

  wallpaper = {
    path = "${./.}/wallpaper.jpg";
    monitor = "LVDS-1";
  };
  monitor = "LVDS-1,1366x768@59.98900,0x0,1";

  nixpkgs.config.allowUnfree = true;

  home-manager.users.tom = {
    programs.kitty.enable = true;
    home.stateVersion = "26.05";
    home.packages = with pkgs; [
      librewolf
      git
      spotify
    ];
  };
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
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
  networking.hostName = "xenon";
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  system.stateVersion = "26.05";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;
}
