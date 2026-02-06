{ ... }:
{
  disko.devices.disk.ssd = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        reserved = {
          size = "16M"; # Microsoft Reserved Partition
          type = "0C01";
        };
        win = {
          size = "350G"; # Microsoft Basic Data (~40 GB)
          type = "0700";
          content = {
            type = "filesystem";
            format = "ntfs";
            extraArgs = [ "-Q" ];
          };
        };
        recovery = {
          size = "300M"; # Windows Recovery Environment (~300 MB)
          type = "2700";
          content = {
            type = "filesystem";
            format = "ntfs";
            extraArgs = [ "-Q" ];
          };
        };
        data = {
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            mountpoint = "/home/tom/ssd";
            mountOptions = [
              "compress=zstd"
              "noatime"
            ];
          };
        };
      };
    };
  };
}
