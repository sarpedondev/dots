{ pkgs, config, ... }: {
  services.k3s.enable = false;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [ "--disable=traefik" ];
  services.k3s.autoDeployCharts = {
    shkeeper = {
      name = "shkeeper";
      repo = "https://vsys-host.github.io/helm-charts";
      version = "1.4.75";
      hash = "sha256-elji+wU+8azkC/lhzF87CbNTkRSMl27ZPVkkY/0ukOA=";
      values = {
        storageClassName = "local-path";
        btc.enabled = true;
        ltc.enabled = true;

        tron_fullnode.url = "http://fullnode.tron.shkeeper.io";
        trx.enabled = true;
        usdt.enabled = true;
        usdc.enabled = true;

        ethereum_shkeeper.extraEnv.LAST_BLOCK_LOCKED = "FALSE";
        eth_fullnode = {
          enabled = false;
          mainnet = true;
          url = "https://fullnode.ethereum.shkeeper.io:8645";
        };
        eth.enabled = true;
        eth_usdt.enabled = true;
        eth_usdc.enabled = true;
        eth_pyusd.enabled = true;

        xrp.enabled = true;
        doge.enabled = false;
      };
    };
  };
  #system.activationScripts.k3sSecrets = {
  #  text = ''
  #    export PATH="${pkgs.kubectl}/bin:$PATH"
  #
  #    kubectl create secret generic bitcoin-rpc \
  #     --from-file=username=${
  #         config.sops.secrets."k3s/secrets/shkeeper/bitcoin-rpc/username".path
  #      } \
  #      --from-file=password=${
  #        config.sops.secrets."k3s/secrets/shkeeper/bitcoin-rpc/password".path
  #      } \
  #     --dry-run=client -o yaml | kubectl apply -f -
  #  '';
  #  deps = [ ];
  #};
}
