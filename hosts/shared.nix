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

  services.udev.extraRules = ''
# Pybrickdev rules for LEGO programmable bricks

# MINDSTORMS NXT brick 
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0002", MODE="666", TAG+="uaccess"

# MINDSTORMS NXT brick in firmware update mode (Atmel SAM-BA mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="03eb", ATTRS{idProduct}=="6124", MODE="666", TAG+="uaccess"

# MINDSTORMS EV3 brick
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0005", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0005", MODE="666", TAG+="uaccess"

# MINDSTORMS EV3 brick in firmware update mode
SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0006", MODE="666", TAG+="uaccess"
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0006", MODE="666", TAG+="uaccess"

# SPIKE Prime hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0008", MODE="666", TAG+="uaccess"

# SPIKE Prime hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0009", MODE="666", TAG+="uaccess"

# SPIKE Essential hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="000c", MODE="666", TAG+="uaccess"

# SPIKE Essential hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="000d", MODE="666", TAG+="uaccess"

# MINDSTORMS Inventor hub
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0010", MODE="666", TAG+="uaccess"

# MINDSTORMS Inventor hub in firmware update mode (DFU mode)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0694", ATTRS{idProduct}=="0011", MODE="666", TAG+="uaccess"
  '';

  programs.adb.enable = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "23.11";
}
