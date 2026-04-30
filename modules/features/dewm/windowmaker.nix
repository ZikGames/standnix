{self, inputs, options, lib, config, ...}: {
options = {
  windowmaker.enable =
  lib.mkEnableOption "windowmaker";
 };
  config = lib.mkIf config.windowmaker.enable {
  flake.nixosModules.windowmaker = { pkgs, lib, ...}: {
  services.xserver.windowManager.windowmaker.enable = true;
  };
   flake.homeModules.windowmaker = { pkgs, lib, ...}: {
      home.packages = with pkgs; [
      dockapps.wmsystemtray
    ];
};
};
}