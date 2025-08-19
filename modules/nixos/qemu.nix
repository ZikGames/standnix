{ pkgs, lib, config, ...}: 
let cfg = config.qemu; in {
  options = {
    qemu.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {  
    environment.systemPackages = with pkgs; [
virt-manager
qemu
libvirt
  dotnet-sdk_8
];

users.groups.libvirtd.members = ["zik"];

virtualisation.libvirtd.enable = true;

virtualisation.spiceUSBRedirection.enable = true;
  };
}