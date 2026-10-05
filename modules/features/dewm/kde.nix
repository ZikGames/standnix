{
  inputs,
  ...
}:
{
  flake-file.inputs.plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };
  flake = {
    nixosModules.kde = { pkgs, lib, ... }: {

      services.desktopManager.plasma6.enable = true;
      services.displayManager.plasma-login-manager = {
        enable = true;
      };
      programs.kdeconnect.enable = true;
      environment.systemPackages = with pkgs; [
        kdotool
        kdePackages.plasma-browser-integration
      ];
      xdg.portal.config.common.default = lib.mkForce "KDE";

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        okular
      ];
    };
    homeModules.kde = { pkgs, ... }: {
      imports = [ inputs.plasma-manager.homeModules.plasma-manager ];
      home.packages = with pkgs; [
        qogir-kde
        qogir-theme
        qogir-icon-theme
        chicago95
      ];
      programs.plasma = {
        enable = true;

        workspace.cursor.theme = "Qogir-Dark";

        configFile = {
          kdeglobals.General.AccentColor = "146,110,228";
          kdeglobals.General.LastUsedCustomAccentColor = "146,110,228";
          kdeglobals.KDE.DefaultDarkLookAndFeel = "com.github.vinceliuice.Qogir-dark";
          kdeglobals.KDE.DefaultLightLookAndFeel = "com.github.vinceliuice.Qogir-light";

          kscreenlockerrc.Greeter.WallpaperPlugin = "org.kde.color";
          kscreenlockerrc."Greeter/Wallpaper/org.kde.color/General".Color = "3,20,32";

          ksplashrc.KSplash.Theme = "com.github.vinceliuice.Qogir";

          kwinrc.NightColor.Active = true;
          kwinrc."org.kde.kdecoration2".BorderSizeAuto = false;
          kwinrc."org.kde.kdecoration2".theme = "kwin4_decoration_qml_plastik";
        };
      };

    };
  };
}
