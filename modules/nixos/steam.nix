{ pkgs, lib, config, ...}: {
 options = {
  steam.enable =
 lib.mkEnableOption "steam enable";
};
 config = lib.mkIf config.steam.enable {
hardware.graphics = {
  ## amdvlk: an open-source Vulkan driver from AMD
  extraPackages = [ pkgs.amdvlk ];
  extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
};
 programs.steam = {
  enable = true;
  remotePlay.openFirewall = true;
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  gamescopeSession.enable = true;
};
  # Created variable for Package path
  environment.shellInit = let
    gperfPkg = builtins.toString pkgs.pkgsi686Linux.gperftools;
      in ''
        export GPERF32_PATH="${gperfPkg}"
      '';
  # Required packages
  environment.systemPackages = with pkgs; [
    steam-run
    steamcmd
    steam-tui
   pkgsi686Linux.gperftools
  # (steam.override {
  # nativeOnly = true;
  #  privateTmp = false;
  # })
  ];

};
  }
