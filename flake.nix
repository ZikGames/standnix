{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
       labwc-manager.url = "github:JaydenPahukula/labwc-manager";
     };
  };

  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.zik-pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/zik-pc/configuration.nix
        ./modules/nixos
        inputs.home-manager.nixosModules.default
        inputs.labwc-manager.homeManagerModules.default
      ];
    };

      
      exampleIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/iso/configuration.nix
          ];
        };

      nixosConfigurations.nixos = mkNixosConfiguration {
        hostname = "zik-pc";
        username = "zik";
        modules = [
          nixos-wsl.nixosModules.wsl
          ./hosts/wsl-win/wsl.nix
        ];
};
}
