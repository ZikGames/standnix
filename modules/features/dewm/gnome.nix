{
  flake = {
    nixosModules.gnome = { pkgs, ... }: {
      services.displayManager.gdm.enable = true;
      services.desktopManager.gnome.enable = true;
      services.gnome.core-apps.enable = true;
      services.gnome.core-developer-tools.enable = false;
      services.gnome.games.enable = false;
      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-user-docs
        totem
        gnome-music
        gnome-logs
        geary
        gnome-calendar
        gnome-contacts
        epiphany
        yelp
        evince
        gnome-font-viewer

      ];
    };
    homeModules.gnome = { pkgs, ... }: {
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
  };
}
