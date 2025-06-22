{ pkgs, lib, config, ...}: 
let cfg = config.labwc; in {
  options = {
    labwc.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
	    dunst
      grim
#      kanshi
      slurp
      wdisplays
      alacritty
      wofi
      sfwbar
      labwc-tweaks-gtk
      labwc-gtktheme
      swaybg
      gscreenshot
      pavucontrol
      nemo-with-extensions
      nemo-fileroller
      file-roller
    ];
    programs.labwc = {
    enable = true;
};
  };
  }
