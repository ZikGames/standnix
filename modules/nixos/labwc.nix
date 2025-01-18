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
     #kanshi
      slurp
      alacritty
      wmenu
      labwc-tweaks-gtk
      labwc-gtktheme
      swaybg
    ];

    
  programs.labwc = {
    enable = true;
  };
};
  }
