{
  # Initialize the GPU before Plymouth starts so the framebuffer does not
  # change underneath greetd during the boot-to-login handoff.
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
