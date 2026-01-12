{ pkgs, ... }:
{
  users.users.tom.shell = pkgs.zsh;
  programs.zsh.enable = true;
  home-manager.users.tom = {
    programs.starship = {
      enable = true;
      settings = {
        palette = "catppuccin_mocha";
        palettes.catppuccin_mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
        character = {
          success_symbol = "[[](green) ❯](sapphire)";
          error_symbol = "[[](red) ❯](sapphire)";
        };
        git_branch.style = "bold mauve";
        directory = {
          truncation_length = 4;
          style = "bold lavender";
        };
      };
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        edit = "sudo -e";
        merge-into-prod = "git checkout prod && git pull && git merge develop && git push && git checkout develop";
        merge-into-develop = "git checkout develop && git pull && git merge prod && git push && git checkout prod";
        update = "sudo nixos-rebuild switch";
        kill-intellij = "pkill -f idea-ultimate";
        nuke = "pkill -f";
        "docker-nuke-confirm-iam-sure" =
          "docker stop $(docker ps -aq) && docker rm $(docker ps -aq) && docker rmi -f $(docker images -aq) && docker volume rm $(docker volume ls -q)";
      };

      history.size = 10000;
      history.ignoreAllDups = true;
      history.path = "$HOME/.zsh_history";
      history.ignorePatterns = [
        "rm *"
        "pkill *"
        "cp *"
      ];
    };
    programs = {
      direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
        stdlib = ''
          use flake
        '';
      };
    };
  };
}
