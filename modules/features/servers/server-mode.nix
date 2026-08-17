{
  self,
  ...
}:
{
  flake = {
    nixosModules.rpi5-server = {
      imports = [
        # self.nixosModules.pihole
        # self.nixosModules.acme
        # self.nixosModules.jellyfin
        # self.nixosModules.nitter
        self.nixosModules.syncthing-server
        self.nixosModules.mihomo
      ];
      services.fail2ban.enable = true;

      services.unbound = {
        enable = true;
        settings.server = {
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

      services.kea.dhcp4 = {
        enable = true;
        settings = {
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

          valid-lifetime = 4000;
        };
      };
    };

    nixosModules.server-mode =
      {
        pkgs,
        ...
      }:
      {
        specialisation.server = {
          inheritParentConfig = false;
          configuration = {
            imports = [
              # self.nixosModules.minecraft
              self.nixosModules.grub
              self.nixosModules.Zik-PC-hardware
            ];
            # inheritParentConfig = false means none of this comes from
            # zik-pc/configuration.nix automatically — has to be set here.
            system.stateVersion = "24.05";
            networking.hostName = "zik-pc-server";
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            environment.systemPackages = with pkgs; [
              jdk25_headless
            ];

            programs.zsh.enable = true;

            users.users.zik = {
              isNormalUser = true;
              description = "zik";
              extraGroups = [
                "networkmanager"
                "pipewire"
                "wheel"
                "video"
                "audio"
              ];
              shell = pkgs.zsh;
            };
          };
        };
      };
  };
}
