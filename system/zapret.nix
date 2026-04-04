{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.zapret;
in
{
  options.zapret = {
    enable = mkEnableOption "Enable DPI (Deep Packet Inspection) bypass";
  };

  config = mkIf cfg.enable {
  
services.zapret-discord-youtube = {
  enable = true;
  config = "general(ALT-11)";
  listGeneral = [ "canary.discord.com" ]; 
};
  
  };
}
