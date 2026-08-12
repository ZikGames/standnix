{
  flake.nixosModules.tuifimanager = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.tuifimanager
    ];
  };
  perSystem = {
  };
}
