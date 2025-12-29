{
  imports = [ ./labwc.nix ./gnome.nix ./kde.nix];
  labwc.enable = false;
  gnome.enable = true;
  kde.enable = false;
}