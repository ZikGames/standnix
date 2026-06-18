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
    users.users.zik = {
      initialPassword = "examle";
      isNormalUser = true;
      extraGroups = [
        "wheel"
      ];
    };
    networking.interfaces.enp4s0 = {
      ipv4.addresses = [
        {
          address = "192.168.3.3";
          prefixLength = 24;
        }
      ];
    };
    boot.loader.raspberry-pi.bootloader = "kernel";
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

}
