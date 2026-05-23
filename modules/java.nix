{ pkgs, ... }:
let
  additionalJDKs = with pkgs; [
    zulu8
    zulu11
    zulu17
    (pkgs.zulu.override { enableJavaFX = true; })
  ];
  mainJDK = pkgs.zulu25;
in
{
  home-manager.users.tom = {
    home.sessionPath = [ "$HOME/.jdks" ];
    home.file = (
      builtins.listToAttrs (
        builtins.map (jdk: {
          name = ".jdks/${jdk.version}";
          value = {
            source = jdk;
          };
        }) additionalJDKs
      )
    );
    home.packages = [ mainJDK ];
  };
}
