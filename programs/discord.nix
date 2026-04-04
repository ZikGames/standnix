{ config, lib, pkgs, ... }:{
 options = {
  discord.enable =
 lib.mkEnableOption "esli menya zabanit discord, to on parasha";
 };
  config = lib.mkIf config.discord.enable { 
  programs.nixcord = {
    enable = true;          # Enable Nixcord (It also installs Discord)
    discord.enable = false; 
    vesktop.enable = true;  # Vesktop
    dorion.enable = false;   # Dorion
#    equibop.enable = true;
    config = {
      useQuickCss = false;   # use out quickCSS
      themeLinks = [        # or use an online theme
        ""
https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/system24-vencord.theme.css
      ];
      frameless = false;                   # Set some Vencord options
      transparent = true;
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
        apiKey = "1a190d389819364e29a1fbbcb27881fa";
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
#        IRememberYou.enable = true;
	BlurNSFW.enable = true;
        roleColorEverywhere.enable = true;
        sendTimestamps.enable = true;
        messageLogger.enable = true;
	biggerStreamPreview.enable = true;
	unlockedAvatarZoom.enable = true;
      };
    };
    dorion = {
      theme = "dark";
      zoom = "0.9";
      blur = "none";       # "none", "blur", or "acrylic"
      sysTray = true;
      openOnStartup = true;
      autoClearCache = true;
      disableHardwareAccel = false;
      rpcServer = true;
      rpcProcessScanner = true;
      pushToTalk = true;
      pushToTalkKeys = ["RControl"];
      desktopNotifications = true;
      unreadBadge = true;
    };
    extraConfig = {
      # Some extra JSON config here
      # ...
    };
  };
  # ...
  };
}
