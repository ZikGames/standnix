{self, inputs, options, lib, config, ...}: {
flake.nixosModules.qemu = { inputs, outputs, pkgs, lib, config, ... }: {
environment.systemPackages = with pkgs; [
qemu
dnsmasq
];
networking.firewall.trustedInterfaces = [ "virbr0" ];
users.groups.libvirtd.members = ["zik"];
virtualisation.libvirtd = {
  enable = true;
  qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
};
programs.virt-manager.enable = true;
virtualisation.spiceUSBRedirection.enable = true;
  };
  
}