{ pkgs, ... }: {
  home-manager.users.tom.programs.mpv = {
    enable = true;
    config = {
      hwdec = "vaapi"; # Force GPU decoding
      vo = "gpu"; # Use OpenGL renderer
      gpu-api = "opengl"; # No Vulkan
      gpu-context = "wayland"; # You are using Wayland
      profile = "gpu-hq"; # High quality shaders
      video-sync = "display-resample"; # Smoother playback timing
      interpolation = "yes"; # Smooth motion
      tscale = "oversample"; # Higher quality interpolation
      scale = "bilinear"; # Lightest-weight scaler for 8K
      cscale = "bilinear";
      deband = "no"; # Turn off expensive debanding for speed
      vd-lavc-threads = 4; # Keep some threads for fallback decode
      cache = "yes";
      cache-secs = 30;
    };
  };
}
