{ config, lib, pkgs, ... }:{
 options = {
  xfce-dotfiles.enable =
 lib.mkEnableOption "xfce";
 };
  config = lib.mkIf config.xfce-dotfiles.enable {
      xfconf.settings = {
      settings = {
    "Net/ThemeName"      = "Chicago95";
    "Net/IconThemeName"  = "Chicago95-tux";
    "Gtk/CursorThemeName" = "Adwaita";
  };
  };
  };
}