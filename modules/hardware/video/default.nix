{ pkgs, config, lib, ... }:
{
  options = {
    hardware.amd.gpu.enable = lib.mkEnableOption "Enables AMD GPU specific hardware accelleration.";
    hardware.intel.gpu.enable = lib.mkEnableOption "Enables Intel GPU specific hardware accelleration.";
  };

  config = {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = lib.mkIf config.hardware.amd.gpu.enable [ 
        pkgs.rocmPackages.clr.icd 
        pkgs.amdvlk 
      ];
    };
    systemd.tmpfiles.rules = lib.mkIf config.hardware.amd.gpu.enable [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
    environment.systemPackages = with pkgs; [
      libva
    ];
  };
}
