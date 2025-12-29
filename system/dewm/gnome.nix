{ pkgs, lib, config, ...}: 
let cfg = config.gnome; in {
  options = {
    gnome.enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
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
networking.firewall = rec {
  allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
  allowedUDPPortRanges = allowedTCPPortRanges;
};

  };
  }
