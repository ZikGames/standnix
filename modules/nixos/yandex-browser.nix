{ config, pkgs, lib, ... }: {
   options = {
  yandex-browser.enable =
  lib.mkEnableOption "яндекс браузер по рофлу по приколу";
};
 config = lib.mkIf config.yandex-browser.enable {
  programs.yandex-browser = {
    enable = true;
    # default is "stable", you can also have "both"
    package = "beta";
    extensions = config.programs.chromium.extensions;

  #  NOTE: the following are only for nixosModule
   extensionInstallBlocklist = [
     # disable the "buggy" extension in beta
     "imjepfoebignfgmogbbghpbkbcimgfpd"
   ];
    homepageLocation = "https://ya.ru";
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