{pkgs, lib, config, ...}: {
imports = [
 ./apps.nix
 ./labwc.nix
 ./steam.nix
 ./discord.nix
 ];

 apps.enable = true;
 labwc.enable = true;
 steam.enable = true;


 

}