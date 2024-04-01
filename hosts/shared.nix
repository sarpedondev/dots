{ config, pkgs, ...}: {
  boot.kernelParams = [ "quiet" "splash" ];
  boot.supportedFilesystems = [ "ntfs" ];

  boot.plymouth.enable = true;
  
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.canTouchEfiVariables = true;

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
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  console.keyMap = "de";
   hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # 
  services.printing.enable = true;

  services.gvfs.enable = true;

  networking.networkmanager.enable = true;
  
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;
  services.xserver.displayManager.sddm.theme = "catppuccin-mocha";
  services.xserver.displayManager.sessionPackages = [ pkgs.hyprland ];

  programs.dconf.enable = true;

  environment.systemPackages = [
    # sddm
    config.nur.repos.MtFBella109.catppuccin-mocha
    config.nur.repos.milahu.recaf-bin
  ];

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.tom = {
    isNormalUser = true;
    description = "Tom";
    extraGroups = [ "networkmanager" "wheel" "docker" "vboxusers" "adbusers" ];
  };
  
  # If Hyprland is only installed via home-manager we need this to generate a session file for sddm

  virtualisation.docker.enable = true;

  programs.gnupg.agent.enable = true;

  #virtualisation.virtualbox.host.enable = true;
  #virtualisation.virtualbox.host.enableExtensionPack = true;
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.x11 = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  };

  programs.adb.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
