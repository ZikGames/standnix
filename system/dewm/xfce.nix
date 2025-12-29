{ config, lib, pkgs, ... }:{
 options = {
  xfce.enable =
 lib.mkEnableOption "xfce";
 };
  config = lib.mkIf config.xfce.enable {
   services.xserver.displayManager.lightdm = {
    enable = true;
};
   services.xserver.desktopManager.xfce = {
    enable = true;
    enableWaylandSession = false;
    noDesktop = false;
   };
   environment.systemPackages = with pkgs; [
file-roller
xfce.xfce4-weather-plugin
xfce.thunar-volman
xfce.xfce4-whiskermenu-plugin
sox libcanberra-gtk3 libcanberra
];
#     environment.sessionVariables = rec {
#    XDG_HOME_X11 = "/home/zik/.x11";
#    XDG_CONFIG_HOME = "$HOME_X11/.config";
#    XDG_DATA_HOME   = "$HOME_X11/.local/share";
#    XDG_STATE_HOME  = "$HOME_X11/.local/state";
#    XDG_RUNTIME_DIR = "$HOME_X11";
#    
#  };
  };
}
