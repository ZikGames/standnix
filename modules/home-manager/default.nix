{pkgs, lib, config, ...}: {
imports = [
 ./apps.nix
  ./discord.nix
 ./sfwbar.nix
# ./kde.nix
 ./heroic.nix
 ./gnome.nix
 ./hyprland.nix
 ];

 apps.enable = true;
  sfwbar.enable = true;
  heroic.enable  =  true;
  hyprland.enable = true;
}
