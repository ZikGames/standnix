{config, pkgs, lib, ... }: 
let cfg = config.hyprland; in {
  options = {
    hyprland.enable = lib.mkEnableOption "WM";
  };

  config = lib.mkIf cfg.enable {
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;    
    settings = {
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(7b8394ff)";
        "col.inactive_border" = "rgba(3b4252ff)";
      };

      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 5;
          passes = 2;
        };
      };

      # Основные бинды
      bind = [
        # Контекстное меню по ПКМ (mouse:273 - правая кнопка)
        ", mouse:273, exec, ${pkgs.wofi}/bin/wofi --show drun"
        
        # Контекстное меню по SUPER+RMB
        "SUPER, mouse:273, exec, ${pkgs.wofi}/bin/wofi --show drun"
        
        # Основные бинды
        "SUPER, Return, exec, ${pkgs.alacritty}/bin/alacritty"
        "SUPER, Q, killactive,"
        "SUPER SHIFT, M, exit,"
        "SUPER, D, exec, ${pkgs.wofi}/bin/wofi --show drun"
      ];

      # Бинды для управления окнами мышью
      bindm = [
        "SUPER, mouse:272, movewindow"   # ЛКМ + SUPER - перемещение окон
        "SUPER, mouse:273, resizewindow" # ПКМ + SUPER - изменение размера
      ];
    };

    extraConfig = ''
      # Автозапуск sfwbar
      exec-once = ${pkgs.sfwbar}/bin/sfwbar
      
      # Правила для окон
      windowrule = float, ^(alacritty)$
      windowrule = float, ^(wofi)$
      
      # Контекстное меню при клике на рабочий стол
      bind = , code:133, exec, ${pkgs.wofi}/bin/wofi --show drun
    '';

  };
};
}