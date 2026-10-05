{ lib, ... }:
let
  wallpaperDir = ../../../config/wallpapers;
  wallpapers = builtins.attrNames (
    lib.filterAttrs (type: type == "regular") (builtins.readDir wallpaperDir)
  );
in
{
  flake.homeModules.wallpapers = {
    xdg.dataFile = lib.listToAttrs (
      map (name: {
        name = "wallpapers/${name}";
        value.source = wallpaperDir + "/${name}";
      }) wallpapers
    );
  };
}
