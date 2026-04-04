{pkgs, lib, config, ... }: {


 options = {
  wayland.enable =
  lib.mkEnableOption "wayland";
};

 config = lib.mkIf config.wayland.enable {
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
      xdg-desktop-portal-gtk
    ];
  };
xdg.portal.config.common.default = "*";

  environment.systemPackages = with pkgs; [
    wayland-utils
  	xwayland
  ];
security.pam.services.swaylock = {};

};
}
