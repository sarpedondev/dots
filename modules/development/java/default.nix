{ pkgs, config, lib, ... }:
let
additionalJDKs = with pkgs; [
    zulu8 (pkgs.zulu.override { enableJavaFX = true; })
    zulu11
  ];
in
{
  options = {
    java.enable = lib.mkEnableOption "Installs jdk 8, 17, and latest lts release";
  };

  config = lib.mkIf config.java.enable {
    home-manager.users.tom = {
      home.sessionPath = [ "$HOME/.jdks" ];
      home.file = (builtins.listToAttrs (builtins.map (jdk: {
              name = ".jdks/${jdk.version}";
              value = { source = jdk; };
              }) additionalJDKs));
      home.packages = [
        pkgs.zulu17
      ];
    };
  };
}
