{
  virtualisation.podman.defaultNetwork.settings.dns_enabled = true;
  virtualisation.oci-containers = {
    backend = "podman";

    /* containers = {

         postgres = {
           image = "docker://postgres:15";
           autoStart = true;

           environment = {
             POSTGRES_USER = "ddrive_user";
             POSTGRES_PASSWORD = "ddrive_pass";
             POSTGRES_DB = "ddrive_db";
           };

           volumes = [ "pgdata:/var/lib/postgresql/data" ];

           ports = [ "5432:5432" ];
         };

         ddrive = {
           image = "docker://forscht/ddrive";
           autoStart = true;

           dependsOn = [ "postgres" ];

           environment = {
             PORT = "8080";
             CHUNK_SIZE = "10475274";
             WEBHOOKS =
               "https://discord.com/api/webhooks/1364235644225978510/liUKT2pICklIUSA5GCjW4vv2yIlPQaXfW1IHI3OuaTapMv3d9zM0c8yWZVtu-fNtBHOe,https://discord.com/api/webhooks/1364235650441941082/AZ_gUhyjGxi366v-hEIbk92xI7oVEAfqEd-7CEyhmLfYKIWGjqmoSPF5s7ogkkx2vCtO,https://discord.com/api/webhooks/1364235654061359224/8VKNw5VJaW51b5p8GOw16ea5TXXUYg_c68zWAdnLxRbSNUNPEComiTG4ThBPhhC9hvHS,https://discord.com/api/webhooks/1364235657274196142/6U_mwS8uOLcTZZkX7IXukN7rCsmJJvNoxHjL-igt1U69M58nFhWrtPYh7e26zc5qqIVT,https://discord.com/api/webhooks/1364235660742889482/RZLj5GZdpSjmyR7cC8FekUmQq8AYcFywoNN-YS8L7jCETMwqlRIPslKBZ72Z7id0Zc7w,https://discord.com/api/webhooks/1364235674148147260/wxECITT1_1KBx-jqFtnDMi08B233vaX9Y-q1UUUSNr_2MVwcThZrk6kITvnREH4eDFPz,https://discord.com/api/webhooks/1364235694397980720/Nv0G-W3MgKuVsexGfmiA7-qFQxOqVCVF-erPp9YxR_7vzT5ywqLYJxCLuYEHJDSn2U8L,https://discord.com/api/webhooks/1364235699922014299/AmHoZ3NHUtNZDw2T0w2XJX89hsya-DpY3IzfZYc8_jz4PnPbeP9HiLuyPunnEAsodx01";
             DATABASE_URL =
               "postgres://ddrive_user:ddrive_pass@postgres:5432/ddrive_db";
             UPLOAD_CONCURRENCY = "4";
           };

           ports = [ "8080:8080" ];
         };
       };
    */
  };
}
