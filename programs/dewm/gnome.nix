{ pkgs, lib, config, ...}: 
let cfg = config.gnome; in {
  options = {
    gnome.enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [ 
    gnome-tour 
    gnome-user-docs 
  ];



  };
  }