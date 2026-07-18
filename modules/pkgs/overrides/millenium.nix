{ self, inputs, ... }:
{
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

  flake.nixosModules.steam-millennium = { pkgs, ... }: {
    programs.steam.package = pkgs.millennium-steam;
    # nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  };
}
