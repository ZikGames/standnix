{pkgs, options, config, ...} :
{
    home.packages = with pkgs; [
      gnome-tweaks
      gnomeExtensions.arcmenu
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      gnomeExtensions.bluetooth-battery-meter
      gnomeExtensions.gsconnect
      gnomeExtensions.user-avatar-in-quick-settings
      gnomeExtensions.xwayland-indicator
      gnomeExtensions.zen
      gnomeExtensions.weather-or-not
      gnomeExtensions.yks-timer
      gnomeExtensions.wayland-or-x11
      gnomeExtensions.pip-on-top
      gnomeExtensions.openweather-refined
    ];
}
