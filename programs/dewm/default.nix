{
  imports = [ ./labwc.nix ./labwc-dotfiles.nix  ./gnome.nix ./gnome-dotfiles.nix ./kde.nix ./kde-dotfiles.nix];
  labwc.enable = true;
  labwc-dotfiles.enable = true;
  gnome.enable = false;
  kde.enable = false;
  kde-dotfiles.enable = false;
}