{
  flake.homeModules.syncthing = {
    services.syncthing = {
      enable = true;
      settings = {
        devices = {
          "zik-rpi5" = {
            id = "35APPDL-UYHXUIV-5N4W6JC-64F4H6D-BI7YJBU-NNEBOGO-3Z74CN2-MM6CWAU";
          };
        };
        folders = {
          "shared" = {
            path = "/home/zik/shared";
            devices = [ "zik-rpi5" ];
          };
        };
      };
    };
  };
}
