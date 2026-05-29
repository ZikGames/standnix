{self, inputs, options, lib, config, outputs, pkgs, ...}: {
  imports = [
  inputs.home-manager.flakeModules.home-manager
  inputs.flake-parts.flakeModules.easyOverlay
  inputs.flake-parts.flakeModules.modules
  # inputs.files.flakeModules.default
  # inputs.disko.flakeModules.default
  ];

  flake.nixOnDroidConfigurations.zik-on-droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.nix-on-droid
      self.nixosModules.home-manager
    ];
  };
  flake.nixosConfigurations.zik-pc = inputs.nixpkgs.lib.nixosSystem {
  specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.Zik-PC
      self.nixosModules.home-manager
    ];
  };
  flake.homeConfigurations.zik = inputs.nixpkgs.lib.homeConfiguration {
    modules = [
      self.homeModules.zik
    ];
  }; # не проверял

  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
      modules = [
        self.nixosModules.iso
     ];
   };
}
