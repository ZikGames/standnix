{self, inputs, options, lib, config, ...}: {
flake.nixosModules.terraria = {}: {
  users.users.zik.extraGroups = ["docker" "terraria"]
};
}