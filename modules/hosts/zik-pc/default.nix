{self, inputs, options, lib, config, ...}: {
  flake.nixosConfigurations.Zik-PC = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.Zik-PC
    ];
  };
  flake.homeConfigurations.zik = inputs.nixpkgs.lib.homeManager {
    modules = [
      self.homeModules.zik
    ];
  };
}