{ pkgs, ... }:
{
  environment.etc."codex/config.toml".source =
    (pkgs.formats.toml { }).generate "codex-system-config.toml" {
      sandbox_mode = "workspace-write";

      sandbox_workspace_write.writable_roots = [
        "/home/tom/.maven-indexer-mcp"
      ];

      mcp_servers = {
        idea.url = "http://127.0.0.1:64342/stream";
        context7.url = "https://mcp.context7.com/mcp";
        nuxt-ui.url = "https://ui.nuxt.com/mcp";

        playwright = {
          command = "${pkgs.playwright-mcp}/bin/playwright-mcp";
          args = [
            "--executable-path"
            "${pkgs.chromium}/bin/chromium"
            "--isolated"
          ];
        };
      };
    };

  home-manager.users.tom = { lib, ... }: {
    home.packages = with pkgs; [
      playwright-mcp
      chromium
      maven-indexer-cli
    ];
    home.file.".agents/skills/maven-indexer".source =
      "${pkgs.maven-indexer-cli.src}/skills/maven-indexer";
    home.activation.createMavenIndexerStateDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p /home/tom/.maven-indexer-mcp
    '';
    programs.codex = {
      enable = true;
      settings = null;
    };
  };
}
