{
  self,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.flake-parts.flakeModules.modules
    # inputs.disko.flakeModules.default
  ];
  flake = {
    nixosConfigurations.zik-pc = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        self.nixosModules.Zik-PC
        self.nixosModules.home-manager
      ];
    };

    nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        self.nixosModules.iso
      ];
    };

    homeConfigurations.zik = inputs.nixpkgs.lib.homeConfiguration {
      modules = [
        self.homeModules.zik
      ];
    };

    nixosConfigurations.zik-rpi5-sd = inputs.nixos-raspberrypi.lib.nixosInstaller {
      specialArgs = {
        inherit (inputs) nixos-raspberrypi;
        inherit self;
      };
      modules = [
        self.nixosModules.rpi5
        self.nixosModules.rpi5-hardware
      ];
    };

    # nixosConfigurations.rpi5 = inputs.nixos-raspberrypi.lib.nixosSystemFull {
    #   specialArgs = {
    #     inherit (inputs) nixos-raspberrypi;
    #     inherit self;
    #   };
    #   modules = [
    #     self.nixosModules.rpi5
    #     self.nixosModules.rpi5-hardware
    #     self.nixosModules.wayland
    #   ];
    # };

    nixOnDroidConfigurations.zik = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
      modules = [ self.nixOnDroidModules.zik ];
    };

    nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.nix-wsl
      ];
    };
  };
}
