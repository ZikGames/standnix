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
        # self.nixosModules.adGuard-home
        # self.nixosModules.minecraft
        # self.nixosModules.jellyfin
        # self.nixosModules.nitter
        self.nixosModules.syncthing-server
        self.nixosModules.mihomo
        # self.nixosModules.keadhcp
        # self.nixosModules.homer
      ];

      services.fail2ban.enable = true;

      networking.firewall = {
        enable = true;
        trustedInterfaces = [ "eth0" ];
        backend = "iptables";
        allowedTCPPorts = [
          80
          443
          59100
        ];
        allowedUDPPorts = [
          16261
          16262
          59100
          59200
        ];
        allowedTCPPortRanges = [
          {
            from = 3030;
            to = 8800;
          }
        ];
        allowedUDPPortRanges = [
          {
            from = 3030;
            to = 8800;
          }
        ];
      };

      networking.nat = {
        enable = true;
        externalInterface = "wld0";
        internalInterfaces = [ "eth0" ];
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
