{self, inputs, options, lib, config, ...}: {
      flake.modules.nixosModules.x11 = { inputs, outputs, pkgs, lib, config, ... }: {
      services.xserver = {
        enable = true;
        xkb.layout = "us,ru";
        xkb.options = "grp:shift_alt_toggle";
      };
  };
  
}