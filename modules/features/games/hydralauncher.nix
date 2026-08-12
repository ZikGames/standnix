{
  flake.nixosModules.hydralauncher = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ hydralauncher ];
  };
}
