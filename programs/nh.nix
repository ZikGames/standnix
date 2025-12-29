{ config, lib, pkgs, ... }:{
 options = {
  nh.enable =
 lib.mkEnableOption "casual thing";
 };
  config = lib.mkIf config.nh.enable {
programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
};
  };
}