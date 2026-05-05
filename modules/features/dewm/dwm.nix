{self, inputs, options, lib, config, ...}: {
 flake.nixosModules.dwm = { pkgs, lib, ...}: {
    services.xserver.windowManager.dwm.enable = true;
  };
    }