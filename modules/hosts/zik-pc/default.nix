{self, inputs, options, lib, config, outputs, ...}: { 
  imports = [
  inputs.home-manager.flakeModules.home-manager
  inputs.flake-parts.flakeModules.easyOverlay
  inputs.flake-parts.flakeModules.modules
  ];
  flake.nixosConfigurations.Zik-PC = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.Zik-PC
      # inputs.minegrub-world-sel-theme.nixosModules.default
      inputs.zapret-discord-youtube.nixosModules.default
      inputs.minegrub-theme.nixosModules.default
    ];
  };
  flake.homeConfigurations.zik = inputs.nixpkgs.lib.homeConfiguration {
    modules = [
      self.homeModules.zik
    ];
  }; # не работает
}