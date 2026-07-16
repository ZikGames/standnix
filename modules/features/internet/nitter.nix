{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.nitter = { pkgs, outputs, ... }: {
    environment.systemPackages = with pkgs; [
      nitter
    ];
    services.nitter = {
      enable = false;

    };
  };
}
