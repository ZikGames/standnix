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
        # self.nixosModules.syncthing-server
      ];
      services.fail2ban.enable = true;
      services.unbound = {
        enable = true;
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
              self.nixosModules.minecraft
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
