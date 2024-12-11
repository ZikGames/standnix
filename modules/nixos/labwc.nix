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
      mako
      grim
     #kanshi
      slurp
      alacritty
      wofi
      labwc-gtktheme
      labwc-tweaks-gtk
      labwc-menu-generator
    ];
  programs.labwc = {
    enable = true;
    options = {
      core.decoration = "server";
      environment = [
    XDG_CURRENT_DESKTOP=wlroots
     
    XKB_DEFAULT_LAYOUT=ru
    XKB_DEFAULT_LAYOUT=ru,us(intl)
    XKB_DEFAULT_OPTIONS=grp:alt_shift_toggle
      ];
    autostart = [
    swaybg -c #341144

      
    ];

      
      
      }
  };

  };
}
