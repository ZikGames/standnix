{
  flake.nixosModules.vcmi = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vcmi
    ];
  };
}
