{
  imports = [ ./labwc-dotfiles.nix ./gnome-dotfiles.nix ./kde-dotfiles.nix ./xfce-dotfiles.nix ];
  labwc-dotfiles.enable = false;
  gnome-dotfiles.enable = false;
  kde-dotfiles.enable = true;
  xfce-dotfiles.enable = false;
}
