{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.labwc = { pkgs, lib, ...}: {
   programs.labwc = {
      enable = true;
      # package = self.packages.${pkgs.stdenv.hostPlatform.system}.labwc-cwrapped;
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
        gscreenshot
        self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-cwrapped
    ];
  };
  perSystem = { pkgs, lib, self', ... }: {
    #   packages.labwc-cwrapped = wrappers.lib.wrapPackage {
    #   inherit pkgs;
    #   settings = {
    #     autostart = [
    #       (lib.getExe self'.packages.noctalia-cwrapped)
    #     ];
    #   };
    # };
  };
}
