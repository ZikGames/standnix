{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    flake-file.url = "github:vic/flake-file";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    nixcord.url = "github:kaylorben/nixcord";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    irefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  minegrub-world-sel-theme = {
    url = "github:Lxtharia/minegrub-world-sel-theme";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
