{ self, inputs, ... }:
{
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

  flake.nixosModules.steam-millennium =

    {
      nixpkgs.overlays = [
        inputs.millennium.overlays.default
        self.overlays.default
      ];
    };
}
