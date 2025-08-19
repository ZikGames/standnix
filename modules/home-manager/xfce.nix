{lpkgs, lib, config, packages, pkgs, ...}: {
 options = {
  xfce.enable =
  lib.mkEnableOption "wayland";
};
  home.packages = with pkgs; [
	xfce.thunar
	xfce.thunar-archive-plugin
	xfce.xfce4-panel
	xfce.xfce4-netload-plugin
	xfce.xfce4-datetime-plugin
	xfce.thunar-volman
	xfce.xfce4-taskmanager
	xfce.xfce4-panel-profiles
	xfce.xfce4-dockbarx-plugin
	xfce.xfce4-settings
	xfce.xfce4-whiskermenu-plugin
    ];
    }