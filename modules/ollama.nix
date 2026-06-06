# /etc/nixos/configuration.nix
{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-rocm;

    # RX 6800 XT is RDNA2 / gfx1030-ish.
    # Only add this if ROCm detection fails:
    #rocmOverrideGfx = "10.3.0";

    #environmentVariables = {
    #  HSA_OVERRIDE_GFX_VERSION = "10.3.0";
    #   OLLAMA_KEEP_ALIVE = "10m";
    # };
  };

  environment.systemPackages = with pkgs; [
    ollama-rocm
    rocmPackages.rocminfo
  ];
}
