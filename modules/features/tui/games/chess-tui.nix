{
  flake.homeModules.chess-tui = { pkgs, ... }: {
    home.packages = [
      pkgs.chess-tui
    ];
  };
}
