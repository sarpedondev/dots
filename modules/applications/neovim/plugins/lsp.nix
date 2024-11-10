{ ... }:
{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      nil_ls = { enable = true; };
      kotlin_language_server = { enable = true; };
      rust_analyzer = { enable = true; installCargo = true; installRustc = true; };
      pyright = { enable = true; };
      html = { enable = true; };
      ts_ls = { enable = true; };
      tailwindcss = { enable = true; };
    };
  };
}
