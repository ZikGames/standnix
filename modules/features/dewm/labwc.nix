{self, inputs, options, lib, config, ...}: {
options = {
  labwc.enable =
  lib.mkEnableOption "labwc";
 };
  config = lib.mkIf config.labwc.enable {
  # flake-file.inputs.labwc-manager.url = "github:ZikGames/labwc-manager";
  flake.homeModules.labwc = { pkgs, lib, ...}: {
      programs.labwc = {
        enable = true;
        # package = 
      };
      home.packages = with pkgs; [
        wl-clipboard
      ];
  };

  perSystem = {pkgs, lib, ...}: {

    # packages.labwc-manager = inputs.wrapper-modules.wrappers.labwc-manager.wrap {
    #   settings = [

    #   ];
    # };

  };
};
}