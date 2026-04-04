  { config, lib, pkgs, ... }:
with lib;

let
  cfg = config.waydroid;
in
{
    options.waydroid = {
    enable = mkEnableOption "Enable DPI (Deep Packet Inspection) bypass";
  };

  config = mkIf cfg.enable {
  virtualisation.waydroid.enable = true;
  virtualisation.waydroid.package = pkgs.waydroid-nftables;
  environment.systemPackages =  [ pkgs.waydroid-helper ];

systemd = {
  packages = [ pkgs.waydroid-helper ];
  services.waydroid-mount.wantedBy = [ "multi-user.target" ];
};
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  #boot.kernel.sysctl = {
  #  "net.ipv4.ip_forward" = 1;
  #  "net.ipv4.conf.all.forwarding" = 1;
  #  "net.ipv6.conf.all.forwarding" = 1;
  #};
};
}
