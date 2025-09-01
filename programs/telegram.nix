{ config, lib, pkgs, ... }:

let
  cfg = config.services.telegram;
in
{
  options.services.telegram = {
    enable = lib.mkEnableOption "anonymous mask";
  };

  config = lib.mkIf cfg.enable {
home-packages = with pkgs; {
telegram-desktop
};
  };
}