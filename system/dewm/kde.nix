{ pkgs, lib, config, ...}: 
let cfg = config.kde; in {
  options = {
    kde.enable = lib.mkEnableOption "kde";
  };

  config = lib.mkIf cfg.enable {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true; # Enable Wayland (preferred)
  };
  services.desktopManager.plasma6.enable = true;
  
  # Optional: Exclude unwanted KDE applications
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa   
    konsole 
  ];
  };
  }