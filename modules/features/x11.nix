{self, inputs, options, lib, config, ...}: {
flake.nixosModules.x11 = { inputs, outputs, pkgs, lib, config, ... }: {
imports = [
  self.nixosModules.windowmaker
  # self.nixosModules.dwm
  self.homeModules.windowmaker
];
  services.xserver = {
    enable = true;
    xkb.layout = "us,ru";
    xkb.options = "grp:shift_alt_toggle";
  };
};
  
}