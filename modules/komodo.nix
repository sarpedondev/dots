{
  pkgs,
  ...
}:

let
  komodoNetwork = "komodo";
  komodoStateDir = "/etc/komodo";
  komodoSecretsFile = "/home/tom/komodo.env";
in
{
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  systemd.tmpfiles.rules = [
    "d ${komodoStateDir} 0750 root root -"
    "d ${komodoStateDir}/mongo-db 0750 root root -"
    "d ${komodoStateDir}/mongo-configdb 0750 root root -"
    "d ${komodoStateDir}/core-keys 0750 root root -"
    "d ${komodoStateDir}/backups 0750 root root -"
  ];

  systemd.services.docker-network-komodo = {
    description = "Create Docker network for Komodo";
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${pkgs.docker}/bin/docker network inspect ${komodoNetwork} >/dev/null 2>&1 \
        || ${pkgs.docker}/bin/docker network create ${komodoNetwork}
    '';
  };

  virtualisation.oci-containers.containers = {
    komodo-mongo = {
      image = "mongo:8";
      autoStart = true;

      cmd = [
        "--quiet"
        "--wiredTigerCacheSizeGB"
        "0.25"
      ];

      environmentFiles = [
        komodoSecretsFile
      ];

      environment = {
        TZ = "Europe/Berlin";
      };

      volumes = [
        "${komodoStateDir}/mongo-db:/data/db"
        "${komodoStateDir}/mongo-configdb:/data/configdb"
      ];

      labels = {
        "komodo.skip" = "";
      };

      extraOptions = [
        "--network=${komodoNetwork}"
        "--network-alias=mongo"
      ];
    };

    komodo-core = {
      image = "ghcr.io/moghtech/komodo-core:2";
      autoStart = true;
      dependsOn = [ "komodo-mongo" ];

      environmentFiles = [
        komodoSecretsFile
      ];

      environment = {
        TZ = "Europe/Berlin";

        KOMODO_DATABASE_ADDRESS = "mongo:27017";
        KOMODO_HOST = "https://komodo.example.com";
        KOMODO_TITLE = "Komodo";

        KOMODO_LOCAL_AUTH = "true";
        KOMODO_DISABLE_USER_REGISTRATION = "true";
        KOMODO_ENABLE_NEW_USERS = "false";

        KOMODO_JWT_TTL = "1-day";
        KOMODO_MONITORING_INTERVAL = "15-sec";
        KOMODO_RESOURCE_POLL_INTERVAL = "1-hr";
      };

      ports = [
        "127.0.0.1:9120:9120"
      ];

      volumes = [
        "${komodoStateDir}/core-keys:/config/keys"
        "${komodoStateDir}/backups:/backups"
      ];

      extraOptions = [
        "--network=${komodoNetwork}"
        "--network-alias=komodo-core"
        "--init"
      ];
    };
  };

  systemd.services.docker-komodo-mongo = {
    after = [ "docker-network-komodo.service" ];
    requires = [ "docker-network-komodo.service" ];
  };

  systemd.services.docker-komodo-core = {
    after = [
      "docker-network-komodo.service"
      "docker-komodo-mongo.service"
    ];
    requires = [
      "docker-network-komodo.service"
      "docker-komodo-mongo.service"
    ];
  };
}
