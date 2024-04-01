{ pkgs, ... }:
let
  additionalJDKs = with pkgs; [ zulu8 zulu17 zulu ];
in
{
  home.sessionPath = [ "$HOME/.jdks" ];
  home.file = (builtins.listToAttrs (builtins.map (jdk: {
    name = ".jdks/${jdk.version}";
    value = { source = jdk; };
  }) additionalJDKs));
}
