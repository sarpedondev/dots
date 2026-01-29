{ ... }:
{
  disko.devices = {
    disk.main = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "500M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          swap = {
            size = "32G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          reserved = {
            size = "16M"; # Microsoft Reserved Partition
            type = "0C01";
          };
          win = {
            size = "250G"; # Microsoft Basic Data
            type = "0700";
            content = {
              type = "filesystem";
              format = "ntfs";
            };
          };
          recovery = {
            size = "300M"; # Windows Recovery Environment
            type = "2700";
            content = {
              type = "filesystem";
              format = "ntfs";
            };
          };
          root = {
            name = "root";
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ];
              mountpoint = "/";
              mountOptions = [
                "compress=zstd"
                "noatime"
              ];
            };
          };
        };
      };
    };
  };
}
