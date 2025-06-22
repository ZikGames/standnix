{ config, lib, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
in
{
  options.heroic.enable = mkEnableOption "heroic";
  config = mkIf config.heroic.enable {
    home.packages = with pkgs; [ 
    heroic
    legendary-heroic 
     ];
  };
}