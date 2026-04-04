{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nix-colors.url = "github:misterio77/nix-colors";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    nixcord = {
    url = "github:kaylorben/nixcord";
  };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    millennium = {
    url = "github:trivaris/millennium?dir=packages/nix";
    inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, zapret-discord-youtube, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
  nixosConfigurations = {
      zik-pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/zik-pc/configuration.nix
        ./system
        ./system/dewm
        ./config/something
        inputs.home-manager.nixosModules.default
	      zapret-discord-youtube.nixosModules.default
      ];
    };
        };
    homeConfigurations."zik" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };

        modules = [ ./hosts/zik-pc/home.nix ];

      };
  };
}
