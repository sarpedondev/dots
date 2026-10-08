{
  pkgs,
  inputs,
  config,
  ...
}:
let
  mavenIndexerSkill = "${pkgs.maven-indexer-cli.src}/skills/maven-indexer";
  mcpServers = {
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
in
{
  environment.etc."codex/config.toml".source =
    (pkgs.formats.toml { }).generate "codex-system-config.toml"
      {
        sandbox_mode = "workspace-write";

        sandbox_workspace_write.writable_roots = [
          "/home/tom/.maven-indexer-mcp"
        ];

        mcp_servers = mcpServers;

        #model = "stealth/union-alpha";
        #model_provider = "openrouter";

        #model_providers = {
        #    openrouter = {
        #      name = "OpenRouter";
        #      base_url = "https://openrouter.ai/api/v1";
        #      wire_api = "responses";
        #      auth = {
        #        command = "cat";
        #        args = [
        #          config.sops.secrets.openrouter-api-key.path
        #        ];
        #      };
        #    };
        #  };
      };

  home-manager.users.tom = { lib, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      t3code
      playwright-mcp
      chromium
      maven-indexer-cli
      bubblewrap
      opencode
    ];
    home.file.".agents/skills/maven-indexer".source = mavenIndexerSkill;
    home.activation.createMavenIndexerStateDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD mkdir -p /home/tom/.maven-indexer-mcp
    '';
    programs.codex = {
      enable = true;
      settings = null;
      # package = inputs.codex-cli-nix.packages.${pkgs.system}.default;
    };
    programs.claude-code = {
      enable = true;
      mutableSettings = true;
      skills.maven-indexer = mavenIndexerSkill;
      mcpServers = lib.mapAttrs (
        _: server:
        server
        // {
          type = if server ? command then "stdio" else "http";
        }
      ) mcpServers;
      settings = {
        attribution.commit = "";
        statusLine = {
          type = "command";
          command =
            "${pkgs.jq}/bin/jq -r "
            + lib.escapeShellArg ''
              [
                "[\(.model.display_name // .model.id // "Claude")]",
                "context: \(if .context_window.used_percentage == null then "--" else "\(.context_window.used_percentage | round)%" end)",
                (.rate_limits.five_hour.used_percentage | select(. != null) | "5h: \(. | round)%"),
                (.rate_limits.seven_day.used_percentage | select(. != null) | "7d: \(. | round)%")
              ] | join(" | ")
            '';
        };
      };
    };
  };
}
