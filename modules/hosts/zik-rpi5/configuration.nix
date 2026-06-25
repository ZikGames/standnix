{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.rpi5 = { config, ... }: {
    # Hardware specific configuration, see section below for a more complete
    # list of modules
    imports = with inputs.nixos-raspberrypi.nixosModules; [
      raspberry-pi-5.base
      raspberry-pi-5.page-size-16k
      raspberry-pi-5.bluetooth
    ];

    services.openssh = {
      enable = true;
      ports = [ 22 ];
      openFirewall = false;
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null;
        UseDns = false;
        PermitRootLogin = "prohibit-password";
      };
    };
    networking.hostName = "zik-rpi5";
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
    users.users.zik = {
      initialPassword = "examle";
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
    networking.interfaces.eth0 = {
      ipv4.addresses = [
        {
          address = "192.168.1.1";
          prefixLength = 24;
        }
      ];
    };
    boot.loader.raspberry-pi.bootloader = "kernel";
    system.nixos.tags =
      let
        cfg = config.boot.loader.raspberryPi;
      in
      [
        "raspberry-pi-${cfg.variant}"
        cfg.bootloader
        config.boot.kernelPackages.kernel.version
      ];
  };
  flake.nixosModules.rpi5-hardware =
    {
      config,
      pkgs,
      lib,
      nixos-raspberrypi,
      ...
    }:
    {
      imports = with nixos-raspberrypi.nixosModules; [
        # Hardware configuration
        raspberry-pi-5.base
        raspberry-pi-5.display-vc4
        self.nixosModules.pi5-configtxt
      ];
    };
  flake.nixosModules.pi5-configtxt = {
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

          # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#enable-pcie
          pciex1 = {
            enable = true;
            value = "on";
          };
          # PCIe Gen 3.0
          # https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#pcie-gen-3-0
          pciex1_gen = {
            enable = true;
            value = "3";
          };

        };

      };
    };
  };
}
