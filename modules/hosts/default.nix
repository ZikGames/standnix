{
  self,
  inputs,
  ...
}:
{
  flake = {
    nixosConfigurations.zik-pc = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        self.nixosModules.Zik-PC
        self.nixosModules.home-manager
      ];
    };

    # nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    #   specialArgs = {
    #     inherit inputs;
    #     outputs = self;
    #   };
    #   modules = [
    #     self.nixosModules.iso
    #   ];
    # };

    homeConfigurations.zik = inputs.nixpkgs.lib.homeConfiguration {
      modules = [
        self.homeModules.zik
      ];
    };

    nixosConfigurations.zik-rpi5-sd = inputs.nixos-raspberrypi.lib.nixosInstaller {
      specialArgs = {
        inherit self;
      };
      modules = [
        (
          { pkgs, ... }:
          {
            environment.systemPackages = [ pkgs.argononed ];

            environment.etc."argononed.conf".text = ''
              fans = 20, 50, 100
              temps = 45, 55, 65
              hysteresis = 5
            '';

            systemd.services.argononed = {
              description = "Argon One fan/power daemon";
              wantedBy = [ "multi-user.target" ];
              after = [ "multi-user.target" ];
              serviceConfig = {
                Type = "simple";
                ExecStart = "${pkgs.argononed}/bin/argononed";
                Restart = "on-failure";
              };
            };
          }
        )
        self.nixosModules.rpi5
        self.nixosModules.rpi5-hardware
      ];
    };

    # nixosConfigurations.rpi5 = inputs.nixpkgs.lib.nixosSystem {
    #   system = "aarch64-linux";
    #   specialArgs = {
    #     inherit (inputs) nixos-raspberrypi;
    #     inherit self;
    #   };
    #   modules = [
    #     self.nixosModules.rpi5
    #     self.nixosModules.rpi5-hardware
    #     ({ nixos-raspberrypi, ... }: {
    #       imports = with nixos-raspberrypi.nixosModules; [
    #         nixos-raspberrypi.lib.inject-overlays
    #         trusted-nix-caches
    #         nixpkgs-rpi
    #         nixos-raspberrypi.lib.inject-overlays-global
    #       ];
    #     })
    #   ];
    # };

    nixOnDroidConfigurations.zik = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import inputs.nixpkgs { system = "aarch64-linux"; };
      modules = [ self.nixOnDroidModules.zik ];
    };

    nixosConfigurations.wsl = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        self.nixosModules.nix-wsl
      ];
    };
  };
}
