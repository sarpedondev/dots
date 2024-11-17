{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    rofi.enable = lib.mkEnableOption "Enables rofi";
  };

  config = lib.mkIf config.rofi.enable {
    home-manager.users.tom = {
      programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        font = lib.mkForce "${config.stylix.fonts.sansSerif.name} 15";
        extraConfig = {
          modi = "drun";
          #icon-theme = "Oranchelo";
          show-icons = true;
          terminal = "kitty";
          drun-display-format = "{icon} {name}";
          display-drun = "   Search";
        };

        theme =
          let
            inherit (config.home-manager.users.tom.lib.formats.rasi) mkLiteral;
          in
          {
            window = {
              width = mkLiteral "600px";
              height = mkLiteral "360px";
              border = mkLiteral "2px";
              border-radius = mkLiteral "20px";
            };

            inputbar = {
              children = map mkLiteral [
                "prompt"
                "entry"
              ];
            };

            prompt = {
              padding = mkLiteral "6px";
              border-radius = mkLiteral "3px";
              margin = mkLiteral "20px 0px 0px 20px";
            };

            listview = {
              padding = mkLiteral "6px 0px 0px";
              margin = mkLiteral "10px 20px 0px 20px";
              columns = 2;
            };

            element = {
              padding = mkLiteral "5px";
            };

            element-icon = {
              size = mkLiteral "32px";
            };

            # Text like "xyz command not found" when you put in nonsense
            textbox = {
              padding = mkLiteral "6px";
            };
          };
      };
    };
  };
}
