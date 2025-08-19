{pkgs, lib, config, packages, ...}: {
 options = {
  xfce.enable =
  lib.mkEnableOption "wayland";
};
	config = lib.mkIf config.xfce.enable {
  programs.kdeconnect = {
  enable = true;
  package = pkgs.valent;
};
services.xserver.desktopManager = {
  xfce.enable = true;
    xfce.enableWaylandSession = true;
  };
  services.displayManager.gdm = {
enable = true;
# settings = {
# AutomaticLoginEnable = true;
# AutomaticLogin = "/home/zik|";
# };


  };
};
}