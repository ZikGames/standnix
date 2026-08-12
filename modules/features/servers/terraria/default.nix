{
  flake.nixosModules.terraria = {
    users.users.zik.extraGroups = [
      "docker"
      "terraria"
    ];
  };
}
