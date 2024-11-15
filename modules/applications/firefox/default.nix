{ pkgs, ... }: {
  home-manager.users.tom.programs.firefox = {
    enable = true;
    profiles.tom = {
      settings = {
        "identity.fxaccounts.enabled" = false;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
      ];
    };
  };
}
