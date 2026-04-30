{self, inputs, options, lib, config, ...}: {
 options = {
  x11.enable =
 lib.mkEnableOption "x11";
 };
  config = lib.mkIf config.x11.enable {
      flake.modules.nixosModules.x11 = { inputs, outputs, pkgs, lib, config, ... }: {
      services.xserver = {
        enable = true;
        xkb.layout = "us,ru";
        xkb.options = "grp:shift_alt_toggle";
      };
  };
  
};
}