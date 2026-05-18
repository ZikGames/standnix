{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.wine = {pkgs, options, ...}: {
  environment.systemPackages = with pkgs; [
    wineWow64Packages.waylandFull
  ];

  };
  flake.homeModules.wine = {}: {

  };
}