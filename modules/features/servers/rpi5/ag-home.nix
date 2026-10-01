{
  flake.nixosModules.adGuard-home = {
    services.adguardhome = {
      enable = true;
      host = "192.168.1.1";
      port = 3003;
      allowDHCP = false;
      settings = {
        dns = {
          upstream_dns = [
            "127.0.0.1:5335"
            # "127.0.0.1:7874"
          ];
        };
        filtering = {
          protection_enabled = true;
          filtering_enabled = true;
        };
        filters =
          map
            (url: {
              enabled = true;
              url = url;
            })
            [
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_9.txt"
              "https://adguardteam.github.io/HostlistsRegistry/assets/filter_11.txt"
            ];
      };
    };
  };
}
