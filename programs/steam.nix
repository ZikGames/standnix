{pkgs, lib, config, ... }: {


 options = {
  steam.enable =
  lib.mkEnableOption "steam";
};

 config = lib.mkIf config.steam.enable
{
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  gamescopeSession.enable = true;
  fontPackages = with pkgs; [ 
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf  
  ];
  extraPackages = with pkgs; [
    steam-unwrapped
    proton-ge-custom-bin
    mangohud
  ];
hardware.graphics = {
  extraPackages = [ pkgs.amdvlk ];
  extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
};
};

};
}