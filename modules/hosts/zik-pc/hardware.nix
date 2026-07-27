{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{

  flake.nixosModules.Zik-PC-hardware =
    {
      config,
      lib,
      pkgs,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.initrd.availableKernelModules = [
        "ahci"
        "ohci_pci"
        "ehci_pci"
        "pata_atiixp"
        "usbhid"
        "usb_storage"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-amd" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/c3206eda-bbdf-4914-8c6f-b99c8f8be9fc";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/FD29-37FC";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-uuid/26540ed8-5b3b-473e-8aae-e0291908fc80";
        fsType = "btrfs";
      };
      fileSystems."/win" = {
        device = "/dev/disk/by-uuid/7D9EF907580C0251";
        fsType = "ntfs";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/4b129734-69cc-4ca0-afe2-4d814ce5cbfb"; }
      ];

      # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
      # (the default) this is the recommended approach. When using systemd-networkd it's
      # still possible to use this option, but it's recommended to use it in conjunction
      # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
      networking.useDHCP = lib.mkDefault true;
      # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
      # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
