{
  imports = [ ./labwc.nix ./gnome.nix ./kde.nix ./xfce.nix ];
  labwc.enable = false;
  gnome.enable = false;
  kde.enable = true;
  xfce.enable = false;
}
