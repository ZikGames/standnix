{ pkgs, lib, config, ...}: 
let cfg = config.labwc; in {
  options = {
    labwc.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
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
      labwc-tweaks-gtk
    ];
  programs.labwc = {
    enable = true;
    options = {
      core.decoration = "server";
    autostart = [
    swaybg -c ../../configs/labwc/wallpaper.png # явите мне борца за свееееееееет, вам вестника тьмы покажу я =]


      
    ];
    themerc = [

# general
border.width: 1
padding.height: 3

# The following options has no default, but fallbacks back to
# font-height + 2x padding.height if not set.
# titlebar.height:

# window border
window.active.border.color: #4a4a48
window.inactive.border.color: #242422

# ToggleKeybinds status indicator
window.active.indicator.toggled-keybind.color: #7b00ff

# window titlebar background
window.active.title.bg.color: #6e6b68
window.inactive.title.bg.color: #b5b4b3

# window titlebar text
window.active.label.text.color: #000000
window.inactive.label.text.color: #000000
window.label.text.justify: left

# window buttons
window.active.button.unpressed.image.color: #000000
window.inactive.button.unpressed.image.color: #000000
    ];
      
      
      }
  };

  };
}
