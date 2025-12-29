{ config, lib, pkgs, ... }:{
 options = {
  xfce.enable =
 lib.mkEnableOption "xfce";
 };
  config = lib.mkIf config.xfce.enable {
    
  };
}