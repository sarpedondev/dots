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

        networking.hostName = "xenon";

        boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
        boot.kernelModules = [ "kvm-intel" ];
        fileSystems."/" =
        { device = "/dev/disk/by-uuid/6d06d702-bbb8-4cda-b415-a9e0864db3da";
          fsType = "ext4";
        };

        fileSystems."/boot" =
        { device = "/dev/disk/by-uuid/3E4A-9648";
          fsType = "vfat";
        };

        swapDevices =
          [ { device = "/dev/disk/by-uuid/b5f5f1ed-b2a6-4bf7-b504-23e380f03557"; }
          ];

          nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
          hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

          # random stuff i havent categorized yet
          services.printing.enable = true;
          programs.gnupg.agent.enable = true;
          networking.wireguard.enable = true;
          services.resolved.enable = true;
          services.mullvad-vpn.enable = true;
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
              gnome.nautilus
              gnome.sushi
              gnome.totem
              jetbrains.pycharm-professional
              jetbrains.idea-ultimate
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
            monitor = "LVDS-1,1366x768@60,0x0,1";
          };

          hyprpaper = {
            enable = true;
            monitor = "LVDS-1";
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
