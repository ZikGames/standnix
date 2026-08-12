{
  flake.nixosModules.pihole = {
    services.pihole-ftl = {
      enable = true;
      settings = {
        webserver.domain = "pihole.zkdl.online";
        webserver.port = "8080o,4443os,[::]:8080o,[::]:4443os";

        misc.privacylevel = 1;
        misc.dnsmasq_lines = [
          "bind-interface"
          "dhcp-option=19,0"
          "dhcp-option=44,0.0.0.0"
          "dhcp-option=45,0.0.0.0"
          "dhcp-option=46,8"
        ];

        # External DNS Servers quad9 and cloudflare
        dns.upstreams = [
          "9.9.9.9"
          "1.1.1.1"
          "127.0.0.1#5335"
        ];

        # Optionally resolve local hosts (domain is optional)
        # dns.hosts = [ "192.168.1.188" ];

        dhcp = {
          interface = "eth0";
          start = "192.168.1.10";
          end = "192.168.1.100";
          router = "192.168.1.1";
          netmask = "255.255.255.0";
          ipv6 = false;
        };
      };

    };
  };
}
