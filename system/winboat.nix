{ config, lib, pkgs, ... }: {
  options = {
  winboat.enable =
 lib.mkEnableOption "seamless windows";
 };
  config = lib.mkIf config.winboat.enable  {
virtualisation.docker = {
  enable = true;
};
  environment.systemPackages = with pkgs; [
    docker-compose
    freerdp
    appimage-run
    gparted
  ];
  boot.kernelModules = [ "iptable_nat" "iptables" ];
  };
}
