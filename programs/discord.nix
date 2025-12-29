{ config, lib, pkgs, ... }:{
 options = {
  discord.enable =
 lib.mkEnableOption "esli menya zabanit discord, to on parasha";
 };
  config = lib.mkIf config.discord.enable { 
  programs.nixcord = {
    enable = true;          # Enable Nixcord (It also installs Discord)
    vesktop.enable = true;  # Vesktop
    dorion.enable = false;   # Dorion
    config = {
      useQuickCss = false;   # use out quickCSS
      themeLinks = [        # or use an online theme
        "https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/system24-vencord.theme.css"
      ];
      frameless = false;                   # Set some Vencord options
      transparent = true;
      plugins = {
        alwaysTrust.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        clearURLs.enable = true;
        customRPC = {
          enable = true;
          appID = "1058352493676986378";
          appName = "Spooky Month";
          buttonOneText = "rickroll";
          buttonOneURL = "https://www.youtube.com/watch?v=rhOC1x8XEOY";
          buttonTwoText = "rickroll";
          buttonTwoURL = "https://www.youtube.com/watch?v=FtutLA63Cp8";
          details = "=]";
          imageBig = "https://media.tenor.com/vYm_m_fp18EAAAAM/spooky-spooky-month.gif";
          imageBigTooltip = "yei";
          imageSmall = "";
          imageSmallTooltip = "";
          state = "=/";
          timestampMode = "discordUptime";
        #  startTime = "1759276800";
        #  endTime = "1761955200";
          type = "watching";
      };
        dearrow = {
          enable = true;
          hideButton = true;
        };
        decor.enable = true;
        fakeNitro.enable = true;
        noF1.enable = true;
        openInApp.enable = true;
        relationshipNotifier.enable = true;
        roleColorEverywhere.enable = true;
        sendTimestamps.enable = true;
        messageLogger.enable = true;
      };
    };
    dorion = {
      theme = "dark";
      zoom = "1.1";
      blur = "acrylic";       # "none", "blur", or "acrylic"
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
