{ config, lib, pkgs, ... }:

let
  cfg = config.services.v2ray;
in
{
  options.services.v2ray = {
    enable = lib.mkEnableOption "winboat dependences";
  };

  config = lib.mkIf cfg.enable {
 services.v2raya = {
  enable = true;
  cliPackage = pkgs.xray;
 };
  };
}