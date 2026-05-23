{
  ...
}:

let
  komodoNetwork = "komodo";
  komodoStateDir = "/etc/komodo/periphery";
  komodoSecretsFile = "/home/tom/komodo.env";
in
{
  systemd.tmpfiles.rules = [
    "d ${komodoStateDir} 0750 root root -"
  ];

  virtualisation.oci-containers.containers.komodo-periphery = {
    image = "ghcr.io/moghtech/komodo-periphery:2";
    autoStart = true;

    environmentFiles = [
      komodoSecretsFile
    ];

    environment = {
      TZ = "Europe/Berlin";
      PERIPHERY_ROOT_DIRECTORY = "/etc/komodo/periphery";
      PERIPHERY_SSL_ENABLED = "false";
      PERIPHERY_INCLUDE_DISK_MOUNTS = "/";
    };

    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
      "${komodoStateDir}:/etc/komodo/periphery"
      "/proc:/proc:ro"
    ];

    extraOptions = [
      "--network=${komodoNetwork}"
      "--network-alias=periphery"
      "--init"
    ];
  };

  systemd.services.docker-komodo-periphery = {
    after = [ "docker-network-komodo.service" ];
    requires = [ "docker-network-komodo.service" ];
  };
}
