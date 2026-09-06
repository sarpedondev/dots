{ pkgs, inputs, ... }:
{
  environment.etc."codex/config.toml".source =
    (pkgs.formats.toml { }).generate "codex-system-config.toml"
      {
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
            env = {
              DISPLAY = ":0";
              WAYLAND_DISPLAY = "wayland-1";
              XDG_RUNTIME_DIR = "/run/user/1000";
              PLAYWRIGHT_MCP_HEADLESS = "false";
            };
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
      t3code
      playwright-mcp
      chromium
      maven-indexer-cli
      bubblewrap
    ];
    home.file.".agents/skills/maven-indexer".source =
      "${pkgs.maven-indexer-cli.src}/skills/maven-indexer";
    home.activation.createMavenIndexerStateDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p /home/tom/.maven-indexer-mcp
    '';
    programs.codex = {
      enable = true;
      settings = null;
      package = inputs.codex-nix.packages.${pkgs.stdenv.hostPlatform.system}.default;
    };
  };
}
