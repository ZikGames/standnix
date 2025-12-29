{
  imports = [ ./labwc-dotfiles.nix ./gnome-dotfiles.nix ./kde-dotfiles.nix ./xfce-dotfiles.nix ];
  labwc-dotfiles.enable = false;
  gnome-dotfiles.enable = true;
  kde-dotfiles.enable = false;
  xfce-dotfiles.enable = false;
}