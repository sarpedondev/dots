{ pkgs, ... }:
let
  additionalJDKs = with pkgs; [
    # JDKs < 17 pull in gtk2 with gtkSupport, which nixpkgs marks broken
    (zulu8.override { gtkSupport = false; })
    (zulu11.override { gtkSupport = false; })
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
