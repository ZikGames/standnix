{
  flake.nixosModules.openxray = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.openxray
    ];
  };
}
