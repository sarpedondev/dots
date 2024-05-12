{ pkgs, config, lib, ... }:
{
  options = {
    hardware.amd.gpu.enable = lib.mkEnableOption "Enables AMD GPU specific hardware accelleration.";
    hardware.intel.gpu.enable = lib.mkEnableOption "Enables Intel GPU specific hardware accelleration.";
  };

  config = {
    hardware.opengl.enable = true;
    systemd.tmpfiles.rules = lib.mkIf config.hardware.amd.gpu.enable [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    hardware.opengl.extraPackages = lib.mkIf config.hardware.amd.gpu.enable [ 
      pkgs.rocmPackages.clr.icd 
      pkgs.amdvlk 
    ];
  };
}
