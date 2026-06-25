{
  self,
  inputs,
  options,
  lib,
  config,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.flake-parts.flakeModules.modules
    # inputs.files.flakeModules.default
    # inputs.disko.flakeModules.default
  ];

  flake.nixOnDroidConfigurations.zik-on-droid = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
    extraSpecialArgs = { inherit inputs; };
    pkgs = import inputs.nixpkgs {
      system = "aarch64-linux";
      config = {
        allowUnfree = true;
      };
    };
    modules = [
      self.nixOnDroidConfigurations.nix-on-droid
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

  flake.installerImages = inputs.nixos-raspberrypi.installerImages.rpi5;
  flake.nixosConfigurations.rpi5 = inputs.nixos-raspberrypi.lib.nixosSystemFull {
    specialArgs = { inherit (inputs) nixos-raspberrypi; };
    modules = [
      self.nixosModules.rpi5
      self.nixosModules.rpi5-hardware
      self.nixosModules.wayland
    ];
  };

  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    specialArgs = { inherit inputs; };
    modules = [
      self.nixosModules.iso
    ];
  };
}
