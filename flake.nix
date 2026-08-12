# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    balatroTUI.url = "github:Passeriform/balatroTUI";
    files = {
      url = "github:mightyiam/files";
      flake = false;
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks-nix.url = "github:cachix/git-hooks.nix";
    home-manager.url = "github:nix-community/home-manager";
    import-tree.url = "github:vic/import-tree";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixcord.url = "github:kaylorben/nixcord";
    nixgl.url = "github:nix-community/nixGL";
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";
    nixvim.url = "github:nix-community/nixvim";
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    tetrotui.url = "github:Strophox/tetro-tui";
    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
    wrappers.url = "github:lassulus/wrappers";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
  };
}
