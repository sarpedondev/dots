{ pkgs, ... }:
{
  home.packages = with pkgs; [ nixfmt ];
  programs.nixvim.plugins = {
    inc-rename.enable = true;
    lsp = {
      enable = true;
      servers = {
        gopls.enable = true;
        templ.enable = true;
        nil_ls = {
          enable = true;
        };
        ccls = {
          enable = true;
        };
        kotlin_language_server = {
          enable = true;
        };
        rust_analyzer = {
          enable = true;
          installCargo = true;
          installRustc = true;
        };
        pyright = {
          enable = true;
        };
        html = {
          enable = true;
        };
        ts_ls = {
          enable = true;
        };
        tailwindcss = {
          enable = true;
        };
        zls = {
          enable = true;
        };
        qmlls = {
          enable = true;
        };
      };
    };

    lsp-format = {
      enable = true;
    };

    none-ls = {
      enable = true;
      sources.formatting = {
        nixfmt.enable = true; # Nix
        black.enable = true; # Python
        isort.enable = true; # Python
        ktlint.enable = true; # Kotlin
        prettier = {
          enable = true;
          disableTsServerFormatter = true;
        }; # Prettier lmao
      };
    };
  };
}
