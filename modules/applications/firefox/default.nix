{ pkgs, ... }: {
  home-manager.users.tom.programs.firefox = {
    enable = true;
    policies = {
      DisableFirefoxAccounts = true;
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      DisplayBookmarksToolbar = "never";
      FirefoxHome.TopSites = false;
      HardwareAcceleration = true;
    };
    profiles.tom = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      search.default = "DuckDuckGo";
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
        ublock-origin
        wappalyzer
        firefox-color
        fastforwardteam
        languagetool
        sponsorblock
        return-youtube-dislikes
        unpaywall
        re-enable-right-click
      ];
    };
  };
}
