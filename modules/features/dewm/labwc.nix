{self, inputs, options, lib, config, ...}: {
#options = {
#  labwc.enable =
#  lib.mkEnableOption "labwc";
# };
#  config = lib.mkIf config.labwc.enable {
  flake-file.inputs.labwc-manager.url = "github:ZikGames/labwc-manager";
  flake.nixosModules.labwc = { pkgs, lib, ...}: {
      programs.labwc = {
        enable = true;
        # package = 
      };
      environment.systemPackages = with pkgs; [
        wl-clipboard
	grim
	labwc-tweaks-gtk
	dracula-theme
	dracula-icon-theme
	qogir-theme
	qogir-icon-theme
	alacritty
	pcmanfm
      ];
  };

  perSystem = {pkgs, lib, ...}: {

    # packages.labwc-manager = inputs.wrapper-modules.wrappers.labwc-manager.wrap {
    #   settings = [

    #   ];
    # };

  };
#};
}
