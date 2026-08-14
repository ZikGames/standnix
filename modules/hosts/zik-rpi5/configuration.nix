{
  flake-file.inputs.nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  # flake-file.inputs.disko.url = "github:nix-community/disko";
  flake = {
    nixosModules.rpi5 =
      {
        self,
        lib,
        ...
      }:
      {
        imports = [
          self.nixosModules.rpi5-server
        ];

        system.stateVersion = "25.11";
        nix.settings.auto-optimise-store = true;
        nixpkgs.config.allowUnfree = true;

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
          "pipe-operators"
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
        networking.hostName = "zik-rpi5";
        # networking.networkmanager.unmanaged = [ "wlan0" ];
        networking.networkmanager.enable = lib.mkForce false;
        networking.wireless = {
          enable = true;
          networks."he-mnie" = {
            psk = "32412wdsa";
            hidden = true;
          };
          userControlled = false;
          interfaces = [ "wlan0" ];
        };

        networking.dhcpcd.extraConfig = ''
          interface wlan0
          metric 100

          interface eth0
          metric 200
        '';

        networking.interfaces.wlan0 = {
          ipv4.addresses = [
            {
              address = "192.168.0.77";
              prefixLength = 24;
            }
          ];
          useDHCP = false;
        };
        networking.interfaces.eth0 = {
          ipv4.addresses = [
            {
              address = "192.168.1.1";
              prefixLength = 24;
            }
          ];
          useDHCP = false;
        };

        networking.nat = {
          enable = true;
          externalInterface = "wlan0";
          internalInterfaces = [ "eth0" ];
        };

        boot.kernel.sysctl = {
          "net.ipv4.ip_forward" = true;
          "net.ipv6.conf.all.forwarding" = true;
        };

        networking.firewall = {
          enable = true;
          extraCommands = ''
            iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT
            iptables -A FORWARD -i wlan0 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
          '';
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
        system.nixos.tags =
          let
            cfg = config.boot.loader.raspberry-pi;
          in
          [
            "raspberry-pi-${cfg.variant}"
            cfg.bootloader
            config.boot.kernelPackages.kernel.version
          ];
        # services.hardware.argonone.enable = true;
        # hardware.i2c.enable = true;
        # boot.initrd.kernelModules = [
        #   "i2c-dev"
        #   "i2c-bcm2835"
        # ];
        # boot.kernelModules = [
        #   "i2c-dev"
        #   "i2c-bcm2835"
        # ];
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

            # i2c_arm = {
            #   enable = true;
            #   value = "on";
            # };
            # i2c_arm_baudrate = {
            #   enable = true;
            #   value = "100000";
            # };

            # audio = {
            #   enable = true;
            #   value = "on";
            # };
            # "gpio-shutdown" = {
            #   enable = true;
            #   value = "on";
            # };

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
