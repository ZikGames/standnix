{self, inputs, options, lib, config, ...}: {
  flake.homeModules.freetube = {pkgs, outputs, ...}: {
    programs.freetube = {
      enable = true;
    };
  };
}