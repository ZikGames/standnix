{self, inputs, options, lib, config, ...}: {
flake.nixosModules.openxray = {pkgs, ...}: {
  environment.systemPackages = [
    pkgs.openxray
  ];
};
}