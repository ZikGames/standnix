{ config, lib, pkgs, ... }:{
 options = {
  x11.enable =
 lib.mkEnableOption "x11";
 };
  config = lib.mkIf config.x11.enable {
      services.xserver = {
        enable = true;
        xkb.layout = "us,ru";
        xkb.options = "grp:shift_alt_toggle";
      };
  };
}