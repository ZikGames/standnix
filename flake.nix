{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  yandex-browser = {
  url = "github:teu5us/nix-yandex-browser";
  inputs.nixpkgs.follows = "nixpkgs";
  };
  nixcord = {
    url = "github:kaylorben/nixcord";
  };
   nix-minecraft.url = "github:Infinidoge/nix-minecraft";
       playit-nixos-module.url = "github:pedorich-n/playit-nixos-module";

     home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
    
         plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
     labwc-manager = {
    url = "github:ZikGames/labwc-manager";
     };
  };
  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations.zik-pc = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/zik-pc/configuration.nix
        ./modules/nixos
        inputs.home-manager.nixosModules.default
        inputs.playit-nixos-module.nixosModules.default
         inputs.nix-minecraft.nixosModules.minecraft-servers
      #  inputs.yandex-browser.nixosModules.system
      ];

    };

      
      exampleIso = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/iso/configuration.nix
          ];
        };
};
}
