{
  flake.nixosModules.syncthing-server = {
    services.syncthing = {
      enable = true;
      openDefaultPorts = true;
      # guiPasswordFile = "/etc/syncthing-gui-password";
      settings = {
        gui.user = "zik";
        devices = {
          "redmi-13C" = {
            id = "HXIV4EF-KAKOS2Z-MGBOIVX-GTQTENZ-2A55KVD-FZG6TVN-24BB5H5-M5MLWQN";
          };
          "zik-pc" = {
            id = "VWZBSZT-B7ZRWVE-4OCBEIZ-DR4SBY3-WLN4WF7-4ZPNOX7-Q23BTVV-DAWAAAY";
          };
        };
        folders = {
          "shared" = {
            path = "/home/zik/shared";
            devices = [
              "redmi-13C"
              "zik-pc"
            ];
          };
        };
      };
    };
  };
}
