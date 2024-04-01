{ inputs, overlays, ... }:
let
lib = inputs.nixpkgs.lib;
config = inputs.nixpkgs.config;
pkgs = inputs.nixpkgs.pkgs;
in
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux"; 
  modules = [
    inputs.home-manager.nixosModules.home-manager
      ../../modules
      {
        nixpkgs.overlays = overlays;

        networking.hostName = "neon";

        boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
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

        nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
        hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

        # random stuff i havent categorized yet
        services.printing.enable = true;
        programs.gnupg.agent.enable = true;
        networking.wireguard.enable = true;
        services.resolved.enable = true;
        services.mullvad-vpn.enable = true;
        # HIP, ROCM and opengl
        hardware.opengl.enable = true;
        systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
        hardware.opengl.extraPackages = [ 
          pkgs.rocmPackages.clr.icd 
          pkgs.amdvlk 
        ];
        home.username = "tom";
        home.homeDirectory = "/home/tom";
        home.stateVersion = "23.11";
        gtk = {
          enable = true;
          theme = {
            name = "Catppuccin-Mocha-Mauve";
            package = (pkgs.catppuccin-gtk.override { accents = [ "mauve" ]; variant = "mocha"; });
          };
          cursorTheme = {
            name = "Catppuccin-Mocha-Mauve-Cursors";
            package = pkgs.catppuccin-cursors.mochaMauve;
            size = 16;
          };
          iconTheme = {
            name = "Qogir";
            package = (pkgs.qogir-icon-theme.override { colorVariants = [ "dark" ]; themeVariants = [ "default" ]; });
          };
        };
        xdg.portal = {
          enable = true;
          config = { common = { default = [      "gtk"    ]; }; };
          extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
        };
        home.packages = with pkgs; [
          python3
            neovim
            kitty-themes
            hyprpaper
            hyprpicker
            wl-clipboard
            nodejs
            roboto
            (nerdfonts.override { fonts = [ "RobotoMono" ]; })
            vesktop
            grimblast
            vlc
            firefox
            gedit
            gimp
            spotify
            davinci-resolve
            gnome.nautilus
            gnome.sushi
            gnome.totem
            jetbrains.pycharm-professional
            jetbrains.idea-ultimate
            jetbrains.clion
            android-studio
            docker-compose
            libsForQt5.polkit-kde-agent
            github-copilot-intellij-agent
            prismlauncher
            unrar
            unzip
        ];
        services.cliphist.enable = true;
        programs.gpg.enable = true;
        fonts.fontconfig.enable = true;
        # end

        hyprland = {
          enable = true;
          monitor = "DP-1,5120x1440@120,0x0,1";
        };

        hyprpaper = {
          enable = true;
          monitor = "DP-1";
          wallpaper = "wallpaper.jpg";
        };

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
