{pkgs, lib, config, packages, ...}: {
 options = {
  xfce.enable =
  lib.mkEnableOption "wayland";
};
	config = lib.mkIf config.xfce.enable {
		services.xserver.desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
	  xfce.enableWaylandSession = true;
    };
  };
}