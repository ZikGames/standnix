{self, inputs, options, lib, config, ...}: {
options = {
  dwm.enable =
  lib.mkEnableOption "dwm";
 };
  config = lib.mkIf config.dwm.enable {
 flake.nixosModules.dwm = { pkgs, lib, ...}: {
    services.xserver.windowManager.dwm.enable = true;
  };
    };
  }