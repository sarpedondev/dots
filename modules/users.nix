{
  users.users.tom = {
    isNormalUser = true;
    description = "Me";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    password = "1234";
  };
}
