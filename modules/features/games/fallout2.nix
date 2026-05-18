{self, inputs, options, lib, config, ...}: {
flake.nixosModules.fallout2 = {pkgs, ...}: {
    environment.systemPackages = [
    pkgs.fallout2-ce
  ];
};
}