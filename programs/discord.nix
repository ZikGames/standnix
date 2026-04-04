{ config, lib, pkgs, ... }:{
 options = {
  discord.enable =
 lib.mkEnableOption "esli menya zabanit discord, to on parasha";
 };
  config = lib.mkIf config.discord.enable { 
  programs.nixcord = {
    enable = true;
    discord.equicord.enable = true;
    vesktop.enable = true;
    config = {
      themeLinks = [ https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/system24-vencord.theme.css ];
      plugins = {
        alwaysTrust.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        ClearURLs.enable = true;
        AutoDNDWhilePlaying = {
      enable = true;
      excludeInvisible = true;
      };
        LastFMRichPresence = {
  enable = true;
	username = "Zik1213";
	statusName = "Prospero";
	useListeningStatus = true;
	nameFormat = "song-first";
	showLastFmLogo = false;
      };
	accountPanelServerProfile = {
	 enable = true;
	 prioritizeServerProfile = true;
	};
  dearrow = {
    enable = true;
    hideButton = true;
      };
	ReviewDB = {
	enable = true;
	hideTimestamps = true;
};
        decor.enable = true;
        fakeNitro.enable = true;
        noF1.enable = true;
        openInApp.enable = true;
        relationshipNotifier.enable = true;
        IRememberYou.enable = true;
        BlurNSFW.enable = true;
        roleColorEverywhere.enable = true;
        sendTimestamps.enable = true;
        messageLogger.enable = true;
        biggerStreamPreview.enable = true;
        unlockedAvatarZoom.enable = true;
      };
    };
  };
  };
}
