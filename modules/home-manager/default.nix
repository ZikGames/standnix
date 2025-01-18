{pkgs, lib, config, ...}: {
imports = [
 ./apps.nix
 ./steam.nix
 ./discord.nix
 ];

 apps.enable = true;
 steam.enable = true;

 

}
