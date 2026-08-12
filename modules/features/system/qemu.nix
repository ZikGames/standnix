{
  flake.nixosModules.qemu =
    {
      pkgs,
      ...
    }:
    {
      users.users.zik.extraGroups = [
        "kvm"
        "libvirtd"
      ];
      environment.systemPackages = with pkgs; [
        qemu
      ];
      networking.firewall.trustedInterfaces = [ "virbr0" ];
      users.groups.libvirtd.members = [ "zik" ];
      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
        qemu.verbatimConfig = ''
          cgroup_device_acl = [
              "/dev/null", "/dev/full", "/dev/zero",
              "/dev/random", "/dev/urandom",
              "/dev/ptmx", "/dev/kvm", "/dev/rtc",
              "/dev/hpet", "/dev/sev",
              "/dev/disk/by-id/*"
          ]
        '';
      };
      programs.virt-manager.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };

}
