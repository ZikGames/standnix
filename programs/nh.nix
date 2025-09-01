{ config, lib, pkgs, ... }:

let
  cfg = config.services.nh;
in
{
  options.services.nh = {
    enable = lib.mkEnableOption "nh - shorter updater";
  };

  config = lib.mkIf cfg.enable {
programs.nh = {
    enable = true;
    autoUpdate = true;
    clean.enable = true;
    flake = "null";
}
  };
}