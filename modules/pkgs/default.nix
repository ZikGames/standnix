{ self, ... }:

{
  perSystem =
    {
      system,
      pkgs,
      overlays,
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
  flake.nixosModules.standnixpkgs = { pkgs, ... }: {
    environment.systemPackages = [
      # self.packages.${pkgs.system}.g3m
      # self.packages.${pkgs.system}.dnd-gunter
      # self.packages.${pkgs.system}.tf2-preloader
    ];
  };
}
