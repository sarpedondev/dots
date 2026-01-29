{ lib, config, ... }:
{
  home-manager.users.tom.home.file.".config/hypr/hyprtoolkit.conf".text = ''
    background=0xff${lib.removePrefix "#" config.theme.colors.bg0.hex}
    base=0xff${lib.removePrefix "#" config.theme.colors.bg1.hex}
    alternate_base=0xff${lib.removePrefix "#" config.theme.colors.bg2.hex}
    text=0xff${lib.removePrefix "#" config.theme.colors.fg0.hex}
    bright_text=0xff${lib.removePrefix "#" config.theme.colors.fg1.hex}
    accent=0xff${lib.removePrefix "#" config.theme.colors.accent0.hex}
    accent_secondary=0xff${lib.removePrefix "#" config.theme.colors.accent1.hex}
  '';
}
