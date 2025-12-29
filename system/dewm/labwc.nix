{ pkgs, lib, config, ...}: 
let cfg = config.labwc; in {
  options = {
    labwc.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
	    dunst
      grim
      alacritty
      wofi
    	python3
      sfwbar
	    lavalauncher
      labwc-tweaks-gtk
      labwc-gtktheme
      swaybg
      gscreenshot
      nemo-with-extensions
      nemo-fileroller
      file-roller
      dracula-theme
      qogir-icon-theme
    ];
programs.labwc = {
  enable = true;
  };
  };
  }
