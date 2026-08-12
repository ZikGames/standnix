{
  flake-file.inputs.nixcord.url = "github:kaylorben/nixcord";
  flake.homeModules.nixcord =
    {
      inputs,
      ...
    }:
    {
      imports = [ inputs.nixcord.homeModules.nixcord ];
      programs.nixcord = {
        enable = true;
        discord.vencord.enable = false;
        discord.equicord.enable = true;
        equibop = {
          enable = true;
          installPackage = true;
        };
        vesktop.enable = false;
        config = {
          themeLinks = [
            "https://raw.githubusercontent.com/refact0r/system24/refs/heads/main/theme/flavors/system24-vencord.theme.css"
          ];
          plugins = {
            alwaysTrust.enable = true;
            betterRoleDot.enable = true;
            betterSessions.enable = true;
            betterSettings.enable = true;
            clearUrls.enable = true;
            autoDndWhilePlaying.enable = true;
            musicRichPresence = {
              enable = true;
              username = "Zik1213";
              statusName = "Prospero";
              useListeningStatus = true;
              missingArt = "placeholder";
              # showLogo = false;
            };
            accountPanelServerProfile = {
              enable = true;
              prioritizeServerProfile = true;
            };
            dearrow = {
              enable = true;
              hideButton = true;
            };
            reviewDb = {
              enable = true;
              hideTimestamps = true;
            };
            decor.enable = true;
            fakeNitro.enable = true;
            noF1.enable = true;
            openInApp.enable = true;
            relationshipNotifier.enable = true;
            iRememberYou.enable = true;
            blurNsfw.enable = true;
            roleColorEverywhere.enable = true;
            sendTimestamps.enable = true;
            messageLogger.enable = true;
            biggerStreamPreview.enable = true;
            unlockedAvatarZoom.enable = true;
            spotifyCrack.enable = true;
            questify.enable = true;
          };
        };
      };
      # services.arrpc = {
      #   enable = true;
      #   package = pkgs.arrpc; # Default
      # };
    };
}
