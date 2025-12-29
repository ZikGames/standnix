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
        ""
https://raw.githubusercontent.com/otsegolo/system24-catppuccin-macchiato-red/refs/heads/main/theme/flavors/system24-catppuccin-macchiato.theme.css        
#https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/system24-vencord.theme.css
      ];
      frameless = true;                   # Set some Vencord options
      transparent = true;
      plugins = {
        alwaysTrust.enable = true;
        betterRoleDot.enable = true;
        betterSessions.enable = true;
        betterSettings.enable = true;
        clearUrLs.enable = true;
        customRpc = {
          enable = true;
          config = {
          appID = "1058352493676986378";
          appName = "something";
          buttonOneText = "rickroll";
          buttonOneURL = "https://www.youtube.com/watch?v=ZbZSe6N_BXs";
          buttonTwoText = "rickroll";
          buttonTwoURL = "https://www.youtube.com/watch?v=ilfYnhXD-bE";
          details = "hello";
          imageBig = "https://media1.tenor.com/m/guTUVan0WHUAAAAC/hello-chat-saul-goodman.gif";
          imageBigTooltip = "o/";
          imageSmall = "https://media.tenor.com/8_ZIDjNl92gAAAAM/gus-gustavo.gif";
          imageSmallTooltip = "/o";
          state = "have a nice time, buddy";
          timestampMode = "discordUptime";
        #  startTime = "1759276800";
        #  endTime = "1761955200";
          type = "watching";
          };
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
