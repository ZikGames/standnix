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
 # package = pkgs.steam-millennium; # скоро
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
    steam-unwrapped
  ];
};
# hardware.graphics = {
#   extraPackages = [ pkgs.amdvlk ];
#   extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
# }; # deprecated
};
}
