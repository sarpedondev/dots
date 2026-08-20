{ pkgs, ... }:
{
  services.k3s = {
    enable = true;
    role = "server";

    # Use the same datastore as a production HA cluster instead of SQLite.
    clusterInit = true;

    extraFlags = [
      "--write-kubeconfig-mode=0640"
      "--write-kubeconfig-group=k3s"
    ];
  };

  users.groups.k3s = { };
  users.users.tom.extraGroups = [ "k3s" ];

  environment.sessionVariables.KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  environment.systemPackages = with pkgs; [
    kubectl
    kubernetes-helm
  ];
}
