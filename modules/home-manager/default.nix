{pkgs, lib, config, ...}: {
imports = [
 ./apps.nix
 ./discord.nix
 ./fonts.nix
 ./sfwbar.nix
 ];

 apps.enable = true;
 fonts.enable = true;
 sfwbar.enable = true;

}
