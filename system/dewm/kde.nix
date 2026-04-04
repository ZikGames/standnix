{ pkgs, lib, config, ...}: 
let cfg = config.kde; in {
  options = {
    kde.enable = lib.mkEnableOption "kde";
  };

  config = lib.mkIf cfg.enable {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.desktopManager.plasma6.enable = true;
  programs.kdeconnect.enable = true;
  environment.systemPackages = with pkgs; [
    kdotool
    kdePackages.plasma-browser-integration
  ];
  
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa   
    okular 
  ];
  };
  }
