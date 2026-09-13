{ pkgs, ... }: {
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amf
        rocmPackages.rocm-runtime
        rocmPackages.hipblas
        rocmPackages.rocm-smi
      ];
    };
  };
}
