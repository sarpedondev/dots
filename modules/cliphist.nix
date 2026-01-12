{pkgs, ...}: {
  home-manager.users.tom = {
    services.cliphist.enable = true;
    home.packages = [
      pkgs.wl-clipboard
    ];
  };
}
