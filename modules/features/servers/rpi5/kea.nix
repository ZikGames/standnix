{
  flake.nixosModules.keadhcp = {
    services.kea.dhcp4 = {
      enable = true;
      settings = {
        authoritative = true;
        interfaces-config = {
          interfaces = [
            "eth0"
          ];
        };
        lease-database = {
          name = "/var/lib/kea/dhcp4.leases";
          persist = true;
          type = "memfile";
        };
        rebind-timer = 2000;
        renew-timer = 1000;
        subnet4 = [
          {
            id = 1;
            pools = [ { pool = "192.168.1.10 - 192.168.1.100"; } ];
            subnet = "192.168.1.0/24";
            option-data = [
              {
                name = "routers";
                data = "192.168.1.1";
              }
              {
                name = "domain-name-servers";
                data = "192.168.1.1";
              }
            ];
          }
        ];

        valid-lifetime = 86400;
      };
    };
  };
}
