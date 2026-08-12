{
  flake.nixosModules.throne = {
    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };
  };
}
