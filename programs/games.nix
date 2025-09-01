  { config, lib, pkgs, ... }:

let
  cfg = config.services.games;
in
{
  options.services.games = {
    enable = lib.mkEnableOption "home-packages games";
  };

  config = lib.mkIf cfg.enable {
    home-packages = with pkgs; [
      doomretro
      openmw
      srb2
      limo
      archipelago
      godot
      beyond-all-reason
      tetrio-desktop
    ];
  };
}