{
  flake.nixosModules.fallout2 = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.fallout2-ce
    ];
  };
}
