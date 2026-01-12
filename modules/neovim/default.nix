{ inputs, ... }: {

   home-manager.users.tom = {
        imports = [ inputs.nixvim.homeModules.nixvim 
./plugins
./set.nix
];

    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      clipboard.register = "unnamedplus";
      colorschemes.catppuccin.enable = true;

      plugins = {
        auto-save.enable = true;
        web-devicons.enable = true;
        presence = {
          enable = true;
          settings.main_image = "file";
        };
        bufferline = {
          enable = true;
          settings.options.separator_style = "slope";
        };
        treesitter = {
          enable = true;
          settings.indent.enable = true;
          nixvimInjections = true;
        };
        treesitter-context.enable = true;
        nvim-tree = {
          enable = true;
          settings.renderer.group_empty = true;
        };
        lualine.enable = true;
      };

      keymaps = [
        {
          mode = "n";
          key = "<C-n>";
          action = "<cmd>NvimTreeToggle<CR>";
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = ":IncRename ";
        }
        {
          mode = "n";
          key = "<Tab>";
          action = "<cmd>bnext<CR>";
        }
        {
          mode = "n";
          key = "<leader>x";
          action = "<cmd>bd<CR><cmd>bprevious<CR>";
        }
      ];
    };
};
}
