{ config, lib, pkgs, ... }:{
 options = {
  wine.enable =
 lib.mkEnableOption "winebotle";
 };
  config = lib.mkIf config.wine.enable {
home.packages = with pkgs; [
#  wineWowPackages.stable
#  wineWowPackages.waylandFull
  (bottles.override {removeWarningPopup = true;})
];
};
}