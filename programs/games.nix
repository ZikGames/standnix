{ config, lib, pkgs, ... }:{
 options = {
  games.enable =
 lib.mkEnableOption "various games yapi";
 };
  config = lib.mkIf config.games.enable {
    home.packages = with pkgs; [
      doomretro
      openmw
      srb2
      # beyond-all-reason
      tetrio-desktop
      openxray
      vcmi
      # zeroad
      jdk25
      classicube
    ];
  };
}
