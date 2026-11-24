{
  lib,
  pkgs,
  config,
  ...
}:

let
  fields = [
    "host"
    "username"
    "path"
    "password"
  ];
  secretName = field: "server-backup/${field}";
in
{
  sops.secrets = lib.genAttrs (map secretName fields) (_: {
    owner = "tom";
  });

  home-manager.users.tom.home.packages = [
    (pkgs.writeShellApplication {
      name = "server-backup";
      runtimeInputs = with pkgs; [
        coreutils
        jq
        openssh
        restic
      ];
      text =
        lib.concatMapStrings (
          field:
          "SECRET_${lib.toUpper field}_FILE=${lib.escapeShellArg config.sops.secrets.${secretName field}.path}\n"
        ) fields
        + builtins.readFile ./server-backup.sh;
    })
  ];
}
