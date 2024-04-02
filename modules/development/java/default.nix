{ pkgs, config, lib, ... }:
let
additionalJDKs = with pkgs; [ zulu8 zulu17 zulu ];
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
  };
  };
}
