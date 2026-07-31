{ pkgs, ... }:
{
  home-manager.users.tom = {
    home.packages = with pkgs; [
      playwright-mcp
      chromium
      maven-indexer-cli
    ];
    home.file.".agents/skills/maven-indexer".source =
      "${pkgs.maven-indexer-cli.src}/skills/maven-indexer";
    programs.codex = {
      enable = true;
      #settings.mcp_servers = {
      #idea.url = "http://127.0.0.1:64342/stream";
      #context7.url = "https://mcp.context7.com/mcp";
      #nuxt-ui.url = "https://ui.nuxt.com/mcp";
      #playwright = {
      #  command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
      #  args = [
      #    "--executable-path"
      #    "${pkgs.chromium}/bin/chromium"
      #    "--isolated"
      #  ];
      #};
      #};
    };
  };
}
