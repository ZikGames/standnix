{ config, pkgs, ... }:

{
  imports = [
    ./system.nix
    ./wayland.nix
    ./waydroid.nix
    ./winboat.nix
    ./steam.nix
    ./qemu.nix
    ./x11.nix
    ./zapret.nix
    ./zsh.nix
  ];

  base.enable = true;
  winboat.enable = true;
  steam.enable = true;
  waydroid.enable = true;
  wayland.enable = true;
  qemu.enable = true;
  x11.enable = false;
  zapret.enable = false;
  zsh.enable = true;  
}
