{self, inputs, lib, config, ...}: {
flake.nixosModules.wayland = { inputs, outputs, pkgs, lib, config, ... }: {
imports = [
  self.nixosModules.labwc
  self.nixosModules.kde
];
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1";
    LD_LIBRARY_PATH = "${pkgs.chromium}/lib";
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      # xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
    ];
  };
xdg.portal.config.common.default = "KDE";

  environment.systemPackages = with pkgs; [
    wayland-utils
  	# xwayland
  ];
# security.pam.services.swaylock = {};
};
}
