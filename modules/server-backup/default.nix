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

  fusermountCompat = pkgs.runCommand "fusermount-compat" { } ''
    mkdir -p $out/bin
    ln -s /run/wrappers/bin/fusermount3 $out/bin/fusermount
  '';
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
        fusermountCompat
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
