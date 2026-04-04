{ pkgs, lib, config, ...}: 
let cfg = config.kde-dotfiles; in {
  options = {
    kde-dotfiles.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      qogir-kde
      qogir-icon-theme
      unrar
    ];

    programs.plasma = {
      enable = true;
      workspace = {
      lookAndFeel = "Dracula";
      cursor.theme = "Qogir";
      iconTheme = "Qogir";
      colorScheme = "Dracula";
      };
      panels = [ 
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
      ];
      shortcuts = { };
    };
  };
  }
