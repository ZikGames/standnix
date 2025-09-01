{ config, lib, pkgs, ... }:

let
  cfg = config.services.thunderbird;
in
{
  options.services.thunderbird = {
    enable = lib.mkEnableOption "mails";
  };

  config = lib.mkIf cfg.enable {
programs.thunderbird = {
  enable = true;
}
  };
}