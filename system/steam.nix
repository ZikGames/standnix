{pkgs, lib, config, ... }: {


 options = {
  steam.enable =
  lib.mkEnableOption "steam";
};
 config = lib.mkIf config.steam.enable
{ 
  programs.steam = {
  enable = true;
#  millennium.enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  gamescopeSession.enable = true;
  fontPackages = with pkgs; [ 
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf  
      raleway
      alegreya
  ];
  extraCompatPackages = with pkgs; [
    proton-ge-bin
    steamtinkerlaunch
 ];
  extraPackages = with pkgs; [
    mangohud
    steam-unwrapped
  ];
};

services.xserver.videoDrivers = ["nvidia"];
hardware.nvidia = {
modesetting.enable = true;
powerManagement.enable = true;
powerManagement.finegrained = false;
open = false;
nvidiaSettings = true;
};
};
}
