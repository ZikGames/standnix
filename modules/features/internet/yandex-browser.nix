{
  flake-file.inputs.yandex-browser = {
    url = "github:sbelcl/nix-yandex-browser";
    inputs.nixpkgs.follows = "nixpkgs";
  };
  flake.nixosModules.yandex-browser = { inputs, ... }: {

    imports = [ inputs.yandex-browser.nixosModules.system ];

    programs.yandex-browser = {
      enable = true;
      # default is "stable", you can also have "both"
      package = "beta";

      # NOTE: the following are only for nixosModule
      extensionInstallBlocklist = [
        # disable the "buggy" extension in beta
        "imjepfoebignfgmogbbghpbkbcimgfpd"
      ];
      homepageLocation = "https://zkdl.ru";
      extraOpts = {
        "HardwareAccelerationModeEnabled" = true;
        "DefaultBrowserSettingEnabled" = false;
        "DeveloperToolsAvailability" = 0;
        "CrashesReporting" = false;
        "StatisticsReporting" = false;
        "DistrStatisticsReporting" = false;
        "UpdateAllowed" = false;
        "ImportExtensions" = false;
        "BackgroundModeEnabled" = false;
        "PasswordManagerEnabled" = false;
        "TranslateEnabled" = false;
        "WordTranslatorDisabled" = true;
        "YandexCloudLanguageDetectEnabled" = false;
        "CloudDocumentsDisabled" = true;
        "DefaultGeolocationSetting" = 1;
        "NtpAdsDisabled" = true;
        "NtpContentDisabled" = true;
      };
    };

  };
}
