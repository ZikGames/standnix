{ config, pkgs, ... }:

{
  imports = [
    ./site.nix
    ./terraria.nix
  ];
    site.enable = false;
    terraria.enable = false;
}