{self, inputs, options, lib, config, ...}: {
flake.nixosModules.heroic = {pkgs, ...}: {
  environment.systemPackages = [
    pkgs.heroic-unwrapped
  ];
};
}