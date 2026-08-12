{
  flake.nixosModules.heroic = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.heroic-unwrapped
    ];
  };
}
