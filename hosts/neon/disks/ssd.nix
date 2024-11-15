{ ... }: {
  disko.devices.disk.ssd = {
    device = "/dev/sda";
    type = "disk";
    content = {
      type = "gpt";
      partitions.data = {
        size = "100%";
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
          mountpoint = "/home/tom/ssd";
          mountOptions = [ "compress=zstd" "noatime" "umask=0000" ];
        };
      };
    }; 
  };
}
