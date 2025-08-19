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
    xwayland.enable = false;
         settings = {
        general = {
          focus_follows_mouse = true;
          border_size = 1;
          gaps_in = 8;
          gaps_out = 10;
          smart_gaps = true;
        };

        input = {
          # Пример смены курсора (выключаем дефолт и используем другой)
          cursor_theme = "Qogir"; # Или любой из установленных в системе
          cursor_size = 24;
          kb_layout = "us,ru";
        };
        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };


        # Переключение рабочих столов win + tab
        bindings = {
          # Тут нужно прописать в extraConfig
        };
      };

      extraConfig = ''
        # Запуск программ один раз при старте
        exec-once = sfwbar -f /home/zik/standnix/modules/configs/t2.config &
                      swaybg -i /home/zik/standnix/modules/configs/fansite_kit_hires_background_01.jpg &
                      lavalauncher -c /home/zik/standnix/modules/configs/lavalauncher.conf &

        # Терминал и файловый менеджер по хоткеям
        bindsym SUPER+Return exec alacritty
        bindsym SUPER+e exec nemo
        bindsym SUPER+d exec wofi --show drun

        # Переключение рабочих столов Win+Tab
        bindsym SUPER+Tab workspace next
      '';
    };
  };
}