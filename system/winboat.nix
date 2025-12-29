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
    freerdp
    docker-compose
    winboat
    # (winboat.override { electron = electron_37; nodejs_24 = nodejs_24; })
  ];
  boot.kernelModules = [ "iptable_nat" "iptables" ];
  };
}
