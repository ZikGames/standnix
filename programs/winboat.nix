{ config, lib, pkgs, ... }:

let
  cfg = config.services.myService;
in
{
  options.services.winboat = {
    enable = lib.mkEnableOption "winboat dependences";
  };

  config = lib.mkIf cfg.enable {
virtualisation.docker = {
  enable = true;
};
  home-packages = with pkgs; [
    docker-compose
    freerdp 
  ];
  boot.kernelModules = [ "iptable_nat" "iptables" ];
  };
}