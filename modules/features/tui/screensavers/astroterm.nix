{
  flake.homeModules.astroterm =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.astroterm
      ];
    };
}
