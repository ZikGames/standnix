{ pkgs, lib, config, ...}: 
let cfg = config.kde-dotfiles; in {
  options = {
    kde-dotfiles.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qogir-kde
      dracula-qt5-theme
    ];

    programs.plasma = {
      enable = true;
      workspace = {
      lookAndFeel = "Dracula";
      cursorTheme = "Qogir";
      iconTheme = "Qogir";
      colorScheme = "Dracula";
      };
      panels = [ ];
      shortcuts = { };
      # Add more plasma-manager options as needed
    };
  };
  }