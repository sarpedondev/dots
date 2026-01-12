{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "1.0.20";
  pname = "guarda";

  src = fetchurl {
    url = "https://github.com/guardaco/guarda-desktop-releases/releases/download/v${version}/Guarda-${version}.AppImage";
    sha256 = "1q55h8j5ki9hq5d8ipwf20haqyxq57w9iqv5qp0z4fw7qpa9gpps";
  };

  appimageContents = appimageTools.extractType1 { inherit pname version src; };
in
appimageTools.wrapType1 {
  inherit pname version src;

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/${pname}.desktop -t $out/share/applications
    substituteInPlace $out/share/applications/${pname}.desktop \
      --replace-fail 'Exec=AppRun' 'Exec=${pname}'
    cp -r ${appimageContents}/usr/share/icons $out/share
  '';

  meta = {
    description = "Crypto Wallet";
    homepage = "https://guarda.com";
    downloadPage = "https://guarda.com/download";
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    license = lib.licenses.unfree;
    platforms = lib.platforms.linux;
  };
}
