{ self, ... }:

{
  flake.nixosModules.standnixpkgs = { pkgs, ... }: {
    environment.systemPackages = [
      # self.packages.${pkgs.system}.g3m
      # self.packages.${pkgs.system}.dnd-gunter
      self.packages.${pkgs.system}.tf2-preloader
    ];
  };
}
