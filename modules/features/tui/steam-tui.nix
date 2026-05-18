{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.steam-tui = {pkgs, ...}: {
    environment.systemPackages = [
      pkgs.steam-tui
      pkgs.steam-cmd
    ];
  };
  perSystem = { pkgs, lib, ...}: {
  };
}