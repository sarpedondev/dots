final: prev: {
  _1password-cli = prev._1password-cli.overrideAttrs (old: rec {
    version = "2.35.0-beta.01";

    src =
      if prev.stdenv.hostPlatform.system == "x86_64-linux" then
        prev.fetchzip {
          url = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_amd64_v${version}.zip";
          hash = "sha256-R1O+u38bEqmAuOhyvm+Zb+xSYi32ySbXZW+EL33UJW8=";
          stripRoot = false;
        }
      else if prev.stdenv.hostPlatform.system == "aarch64-linux" then
        prev.fetchzip {
          url = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_arm64_v${version}.zip";
          hash = "sha256-HlmNAnHR4WT1qVwBSWH2kR+wEtET0Yq7M0VKrqzdts0=";
          stripRoot = false;
        }
      else
        throw "1Password CLI beta overlay only configured for Linux";
  });
}
