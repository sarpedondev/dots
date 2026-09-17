{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  environment.systemPackages = with pkgs; [ sops ];
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = "/home/tom/.config/sops/age/keys.txt";
    secrets = {
      #"passwords/root".neededForUsers = true;
      #"passwords/tom".neededForUsers = true;
      openrouter-api-key = { owner = "tom"; };
    };
  };
}
