{
  flake-file.inputs = {
    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };
  flake = {
    nixosModules.rpi5 =
      {
        self,
        pkgs,
        ...
      }:
      {
        imports = [
          self.nixosModules.rpi5-server
          self.nixosModules.tuifimanager
        ];

        system.stateVersion = "25.11";
        nix.settings.auto-optimise-store = true;
        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
        ];

        environment.systemPackages = with pkgs; [
          # brogue-ce
          # chess-tui
        ];

        boot.zfs.forceImportRoot = false;
        services.openssh = {
          enable = true;
          ports = [ 2222 ];
          openFirewall = true;
          settings = {
            PasswordAuthentication = false;
            # AllowUsers = null;
            UseDns = false;
            PermitRootLogin = "prohibit-password";
          };
        };
        nix.settings = {
          extra-substituters = [
            "https://nixos-raspberrypi.cachix.org"
          ];
          extra-trusted-public-keys = [
            "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
          ];
          trusted-users = [
            "root"
            "@wheel"
            "zik"
          ];
        };

        time.timeZone = "Europe/Moscow";
        networking = {
          interfaces.eth0 = {
            useDHCP = false;
            ipv4.addresses = [
              {
                address = "192.168.1.1";
                prefixLength = 24;
              }
            ];
          };
          defaultGateway = {
            address = "192.168.0.1";
            interface = "wld0";
            metric = 100;
          };
          hostName = "zik-rpi5";
        };
        services.timesyncd.enable = false;
        services.chrony = {
          enable = false;
          servers = [
            "0.ru.pool.ntp.org"
            "1.ru.pool.ntp.org"
            "ntp.ubuntu.com"
          ];
        };
        # nixpkgs.buildPlatform = {
        #   system = "x86_64-linux";
        # };
        nixpkgs.hostPlatform = "aarch64-linux";
        # programs.nh.enable = true;

        systemd.services.wait-for-chrony = {
          description = "Wait for chrony to synchronize";
          wantedBy = [ "multi-user.target" ];
          before = [ "mihomo.service" ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = "${pkgs.chrony}/bin/chronyc waitsync 60 0.1";
          };
        };
        systemd.services.mihomo = {
          after = [ "wait-for-chrony.service" ];
          wants = [ "wait-for-chrony.service" ];
        };

        users.users.nixos = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "networkmanager"
            "video"
          ];
          # Allow the graphical user to login without password
          initialHashedPassword = "";
        };
        users.users.root.openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFk7Q0GeJunEDWZTJIQV93YrIFtnNCkcnx7wnzkderc zik@zik-pc"
        ];
        users.users.zik = {
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFk7Q0GeJunEDWZTJIQV93YrIFtnNCkcnx7wnzkderc zik@zik-pc"
          ];
          initialPassword = "examle";
          isNormalUser = true;
          extraGroups = [
            "wheel"
          ];
        };
      };

    nixosModules.rpi5-hardware =
      {
        nixos-raspberrypi,
        self,
        config,
        ...
      }:
      {
        imports = with nixos-raspberrypi.nixosModules; [
          # Hardware configuration
          raspberry-pi-5.base
          raspberry-pi-5.page-size-16k
          raspberry-pi-5.bluetooth
          # raspberry-pi-5.display-vc4
          self.nixosModules.pi5-configtxt
        ];
        boot.tmp.useTmpfs = true;
        # services.hardware.argonone.enable = true;
        hardware.i2c.enable = true;
        nixpkgs.overlays = [
          (final: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
              (pyFinal: pyPrev: {
                pytest-regressions = pyPrev.pytest-regressions.overridePythonAttrs (old: {
                  doCheck = false;
                });
              })
            ];
          })
        ];

        system.nixos.tags =
          let
            cfg = config.boot.loader.raspberry-pi;
          in
          [
            "raspberry-pi-${cfg.variant}"
            cfg.bootloader
            config.boot.kernelPackages.kernel.version
          ];
      };
    nixosModules.pi5-configtxt = {
      hardware.raspberry-pi.config = {
        all = {
          # [all] conditional filter, https://www.raspberrypi.com/documentation/computers/config_txt.html#conditional-filters

          options = {
            # https://www.raspberrypi.com/documentation/computers/config_txt.html#enable_uart
            # in conjunction with `console=serial0,115200` in kernel command line (`cmdline.txt`)
            # creates a serial console, accessible using GPIOs 14 and 15 (pins
            #  8 and 10 on the 40-pin header)
            enable_uart = {
              enable = true;
              value = true;
            };
            # https://www.raspberrypi.com/documentation/computers/config_txt.html#uart_2ndstage
            # enable debug logging to the UART, also automatically enables
            # UART logging in `start.elf`
            uart_2ndstage = {
              enable = true;
              value = true;
            };
          };

          # Base DTB parameters
          # https://github.com/raspberrypi/linux/blob/a1d3defcca200077e1e382fe049ca613d16efd2b/arch/arm/boot/dts/overlays/README#L132
          base-dt-params = {

            i2c_arm = {
              enable = true;
              value = "on";
            };

            i2c_arm_baudrate = {
              enable = true;
              value = "100000";
            };
            # # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#enable-pcie
            # pciex1 = {
            #   enable = true;
            #   value = "on";
            # };
            # # PCIe Gen 3.0
            # # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#pcie-gen-3-0
            # pciex1_gen = {
            #   enable = true;
            #   value = "3";
            # };

          };

        };
      };
    };
  };
}
