{
  flake.nixosModules.limo = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      (limo.override { withUnrar = true; })
    ];
  };
}
