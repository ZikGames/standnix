{
  flake-file.inputs.tetrotui = {
    url = "github:Strophox/tetro-tui";
  };
  flake.homeModules.tetro = { pkgs, ... }: {
    home.packages = with pkgs; [ tetrotui ];
  };
}
