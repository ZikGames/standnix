{
  flake.homeModules.brogue-ce = { pkgs, ... }: {
    home.packages = [
      pkgs.brogue-ce
    ];
  };
}
