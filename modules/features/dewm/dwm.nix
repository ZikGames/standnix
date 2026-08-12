{
  flake.nixosModules.dwm = {
    services.xserver.windowManager.dwm.enable = true;
  };
}
