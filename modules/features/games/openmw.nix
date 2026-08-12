{
  flake.nixosModules.openmw = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.openmw
      # pkgs.portmod
    ];
  };
}
