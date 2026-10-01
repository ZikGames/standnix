{
  flake.nixosModules.unbound = {
    services.unbound = {
      enable = true;
      settings = {
        server = {
          interface = [
            "127.0.0.1"
            "192.168.1.1"
          ];
          access-control = [
            "127.0.0.0/8 allow"
            "192.168.1.0/24 allow"
          ];
        };
      };
    };
  };
}
