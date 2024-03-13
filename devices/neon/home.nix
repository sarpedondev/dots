{ config, pkgs, ... }: {
  imports = [ 
    ../shared-home.nix
    ../../configs/hyprland.nix 
    ../../configs/waybar.nix
    ../../configs/rofi.nix
    ../../configs/kitty.nix
    ../../configs/git.nix
  ];

  home.packages = with pkgs; [
    python3
    neovim
    kitty-themes
    roboto
    (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    vesktop
    mullvad-vpn
    grimblast
    qbittorrent
    vlc
    firefox
    gedit
    gimp
    spotify
    davinci-resolve
    dolphin
    jetbrains.pycharm-professional
    jetbrains.idea-ultimate
    jetbrains.clion
    android-studio
    docker-compose
    libsForQt5.polkit-kde-agent
    github-copilot-intellij-agent
    # for building tauri apps
    yarn
    nodePackages.nodejs
    rustc
    cargo
    cargo-tauri
    #pkgs.catppuccin-kvantum
  ];
}
