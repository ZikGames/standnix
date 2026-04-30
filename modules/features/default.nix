 {self, inputs, options, lib, config, ...}: {
  imports = [
  inputs.home-manager.flakeModules.home-manager
  inputs.flake-parts.flakeModules.easyOverlay
  inputs.flake-parts.flakeModules.modules
  ];
 }