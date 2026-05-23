{self, inputs, options, lib, config, outputs, ...}: {
  imports = [
  inputs.home-manager.flakeModules.home-manager
  inputs.flake-parts.flakeModules.easyOverlay
  inputs.flake-parts.flakeModules.modules
  inputs.rust-flake.flakeModules.default
  inputs.rust-flake.flakeModules.nixpkgs
  ];

  # nixOnDroidConfigurations.default = inputs.nixpkgs.lib.nixOnDroidConfiguration {
  #   specialArgs = { inherit inputs; };
  #   modules = [
  #     self.nixosModules.nix-on-droid
  #     self.nixosModules.home-manager
  #   ];
  # };
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
}
