{ pkgs, lib, config, ...}: 
let cfg = config.gnome-dotfiles; in {
  options = {
    gnome-dotfiles.enable = lib.mkEnableOption "kde";
  };

  config = lib.mkIf cfg.enable {
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
      ];
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };
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
  };
  }