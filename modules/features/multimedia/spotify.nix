{ self, ... }:
{
  flake.nixosModules.spotify = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      spotify
    ];
  };
}
