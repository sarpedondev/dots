{ lib, config, ... }:
let
  # --- helpers: parsing + formatting ---
  mod = a: b: a - (b * (a / b));

  # "#rrggbb" -> { r = 0..255; g = 0..255; b = 0..255; }
  hexToRgb =
    hex:
    let
      s = lib.removePrefix "#" hex;
      r = builtins.fromJSON "0x${builtins.substring 0 2 s}";
      g = builtins.fromJSON "0x${builtins.substring 2 2 s}";
      b = builtins.fromJSON "0x${builtins.substring 4 2 s}";
    in
    {
      inherit r g b;
    };

  # {r,g,b} -> "rgb(r, g, b)"
  rgbString = rgb: "rgb(${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b})";

  # {r,g,b} + alpha 0..1 -> "rgba(r, g, b, a)"
  rgbaString = rgb: a: "rgba(${toString rgb.r}, ${toString rgb.g}, ${toString rgb.b}, ${toString a})";

  # Convert RGB -> HSL (numbers; h in [0..360), s/l in [0..100])
  # Uses floats; good enough for theming.
  rgbToHsl =
    rgb:
    let
      rf = (rgb.r / 255.0);
      gf = (rgb.g / 255.0);
      bf = (rgb.b / 255.0);

      max = lib.max rf (lib.max gf bf);
      min = lib.min rf (lib.min gf bf);
      d = max - min;

      l = (max + min) / 2.0;

      s = if d == 0.0 then 0.0 else d / (1.0 - (lib.abs ((2.0 * l) - 1.0)));

      hPrime =
        if d == 0.0 then
          0.0
        else if max == rf then
          ((gf - bf) / d) mod 6.0
        else if max == gf then
          ((bf - rf) / d) + 2.0
        else
          ((rf - gf) / d) + 4.0;

      h = 60.0 * hPrime;
      hNorm = if h < 0.0 then h + 360.0 else h;

      round = x: builtins.floor (x + 0.5);
    in
    {
      h = round hNorm;
      s = round (s * 100.0);
      l = round (l * 100.0);
    };

  hslString = hsl: "hsl(${toString hsl.h}, ${toString hsl.s}%, ${toString hsl.l}%)";
  hslaString =
    hsl: a: "hsla(${toString hsl.h}, ${toString hsl.s}%, ${toString hsl.l}%, ${toString a})";

  # Build a rich color record from hex
  mkColor =
    hex:
    let
      rgb = hexToRgb hex;
      hsl = rgbToHsl rgb;
    in
    {
      inherit hex rgb hsl;
      rgbString = rgbString rgb;
      rgbaString = a: rgbaString rgb a;
      hslString = hslString hsl;
      hslaString = a: hslaString hsl a;
    };

  hexType = lib.types.strMatching "#[0-9a-fA-F]{6}";
in
{
  options.theme = {
    enable = lib.mkEnableOption "My declarative palette";

    palette = lib.mkOption {
      type = lib.types.attrsOf hexType;
      description = "Hex palette (e.g. #rrggbb).";
      default = { };
    };

    # Optional: default alpha used for rgba/hsla helpers
    alpha = lib.mkOption {
      type = lib.types.number;
      default = 1.0;
      description = "Default alpha for rgba/hsla string helpers.";
    };

    colors = lib.mkOption {
      # This is the generated rich structure
      type = lib.types.attrs;
      readOnly = true;
      description = "Generated colors with multiple formats.";
    };
  };

  config = lib.mkIf config.theme.enable (
    let
      alpha = config.theme.alpha;
      colors = lib.mapAttrs (
        _name: hex:
        let
          c = mkColor hex;
        in
        {
          hex = c.hex;
          rgb = c.rgb;
          hsl = c.hsl;
          rgbString = c.rgbString;
          rgbaString = c.rgbaString alpha;
          hslString = c.hslString;
          hslaString = c.hslaString alpha;
        }
      ) config.theme.palette;
    in
    {
      theme.colors = colors;
    }
  );
}
