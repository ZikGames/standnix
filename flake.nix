{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nixcord.url = "github:kaylorben/nixcord";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    wrappers.url = "github:lassulus/wrappers";
    # rust-flake.url = "github:juspay/rust-flake";
    # conan-flake.url = "git+https://codeberg.org/tarcisio/conan-flake";
    # files.url = "github:mightyiam/files";
    # disko.url = "github:nix-community/disko";
    # agenix.url = "github:ryantm/agenix";
    # agenix-rekey.url = "github:oddlama/agenix-rekey";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
