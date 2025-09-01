{ pkgs, lib, config, ...}: 
let cfg = config.kde-dotfiles; in {
  options = {
    kde-dotfiles.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
  programs.plasma = {
    enable = true;
    overrideConfig = true; 
  regionalSettings = {
  language = "ru";
  numeric = "ru_RU.UTF-8";
  time = "ru_RU.UTF-8";
  currency = "ru_RU.UTF-8";
};
  theme = {
  name = "dracula";
  icons = "qogir-icon-theme";
  cursors = "breeze-cursors";
};
panels = [
  {
    location = "bottom";
    widgets = [
      "org.kde.plasma.taskmanager"
      "org.kde.plasma.systemtray"
    ];
  }
];
  };
  };
  }