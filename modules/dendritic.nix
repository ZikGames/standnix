{ inputs, ... }:
{
  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.home-manager.flakeModules.home-manager
    inputs.flake-parts.flakeModules.easyOverlay
    inputs.flake-parts.flakeModules.modules
  ];
}
