{ self, inputs, ... }:
{
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
  perSystem =
    {
      system,
      pkgs,
      # overlays,
      config,
      final,
      ...
    }:
    {
      # _module.args.pkgs = import inputs.nixpkgs {
      #   inherit system;
      #   overlays = [
      #     inputs.millennium.overlays.default
      #   ];
      #   config = { };
      # };
    };
  flake.nixosModules.steam-millennium = { pkgs, ... }: {
    programs.steam.package = pkgs.millennium-steam;
    # nixpkgs.overlays = [ inputs.millennium.overlays.default ];
  };
}
