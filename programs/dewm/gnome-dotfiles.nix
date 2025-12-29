{ pkgs, lib, config, ...}: 
let cfg = config.gnome-dotfiles; in {
  options = {
    gnome-dotfiles.enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
  dconf.enable = true;
  dconf.settings = {
    "org/gnome/shell" = {
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "gsconnect@andyholmes.github.io"
        "Bluetooth-Battery-Meter@maniacx.github.com"
        "pip-on-top@rafostar.github.com"
        "arcmenu@arcmenu.com"
        "zen@le0.gs"
      ];
    };
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
    };
  };
      home.packages = with pkgs; [
      adwsteamgtk
      gnome-tweaks
      gnomeExtensions.toggle-proxy
      gnomeExtensions.arcmenu
      gnomeExtensions.appindicator
      gnomeExtensions.dash-to-panel
      gnomeExtensions.bluetooth-battery-meter
      gnomeExtensions.gsconnect
      gnomeExtensions.user-avatar-in-quick-settings
      gnomeExtensions.xwayland-indicator
      gnomeExtensions.zen
      gnomeExtensions.rounded-window-corners-reborn
      gnomeExtensions.weather-or-not
      gnomeExtensions.yks-timer
      gnomeExtensions.wayland-or-x11
      gnomeExtensions.pip-on-top
      gnomeExtensions.openweather-refined
      gnomeExtensions.dock-from-dash
      gnomeExtensions.user-themes
      gnomeExtensions.user-themes-x
    ];
  };
  }