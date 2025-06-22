{ config, lib, pkgs, ... }:

{
  options.kde.enable = lib.mkEnableOption "KDE";

  config = lib.mkIf config.kde.enable {
    services.desktopManager.plasma6.enable = true;
  };
}