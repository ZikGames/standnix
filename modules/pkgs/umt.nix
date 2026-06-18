{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.template = { }: { };
  flake.homeModules.template = { }: { };
  perSystem = { pkgs, lib, ... }: {

  };
}
