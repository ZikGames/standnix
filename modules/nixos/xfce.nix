{pkgs, lib, config, packages, ...}: {
 options = {
  xfce.enable =
  lib.mkEnableOption "wayland";
};
	config = lib.mkIf config.xfce.enable {
		services.xserver.desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  environment.systemPackages = with pkgs; [
	xfce.thunar
	xfce.thunar-archive-plugin
	xfce.xfce4-panel
	xfce.xfce4-taskmanager
	xfce.xfce4-panel-profiles
	xfce.xfce4-dockbarx-plugin
	xfce.xfce4-settings
    ];
    };
}