{ pkgs, ... }:
{
  home-manager.users.tom.programs.librewolf = {
    enable = true;
    policies = {
      SanitizeOnShutdown = {
        Cache = false;
        Cookies = false;
        Downloads = false;
        FormData = false;
        History = false;
        Sessions = false;
        SiteSettings = false;
        OfflineApps = false;
        Locked = false;
      };
      DisplayBookmarksToolbar = "never";
    };
    profiles.tom = {
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
      search = { };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
        wappalyzer
        firefox-color
        sponsorblock
        return-youtube-dislikes
        re-enable-right-click
      ];
    };
  };
}
