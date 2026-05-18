{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.tuifimanager = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.tuifimanager
    ];
  };
  perSystem = { pkgs, lib, ...}: {
  };
}