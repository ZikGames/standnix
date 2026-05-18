{self, inputs, options, lib, config, ...}: {
flake.nixosModules.waydroid = {}: {
virtualisation.waydroid = {
  enable = true;
};
};
}