{ pkgs, ... }:
{
  home.packages = with pkgs; [ nixfmt-rfc-style ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls = {
          enable = true;
          settings.formatting.command = [ "nixfmt" ];
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
      };
    };
    lsp-format = {
      enable = true;
      lspServersToEnable = [ "nil_ls" ];
    };
  };
}
