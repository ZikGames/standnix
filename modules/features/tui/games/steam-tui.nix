{
  flake.nixosModules.steam-tui = { pkgs, ... }: {
    environment.systemPackages = [
      pkgs.steam-tui
      pkgs.steam-cmd
    ];
  };
}
