{
  self,
  ...
}:
{
  flake.nixosModules.labwc = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      labwc-tweaks-gtk
      # dracula-theme
      # dracula-icon-theme
      # qogir-theme
      qogir-icon-theme
      alacritty
      pcmanfm
      gscreenshot
      wlr-randr
      swappy
      slurp
      swayidle
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-cwrapped
    ];
  };
  flake.homeModules.labwc = {
    wayland.windowManager.labwc = {
      enable = true;
      autostart = [
        "noctalia-shell &"
      ];
      environment = [
        "XDG_CURRENT_DESKTOP=labwc:wlroots"
        "XKB_DEFAULT_LAYOUT=us,ru"
      ];
      rc = {
        theme = {
          name = "nord";
          cornerRadius = 8;
          font = {
            "@name" = "FiraCode";
            "@size" = "11";
          };
        };
        keyboard = {
          default = true;
          keybind = [
            # <keybind key="W-Return"><action name="Execute" command="foot"/></keybind>
            {
              "@key" = "C-Print";
              action = {
                "@name" = "Execute";
                "@command" = "gscreenshot -s";
              };
            }
            {
              "@key" = "C-A-t";
              action = {
                "@name" = "Execute";
                "@command" = "alacritty";
              };
            }
            # <keybind key="W-Esc"><action name="Execute" command="loot"/></keybind>
            {
              "@key" = "Print";
              action = {
                "@name" = "Execute";
                "@command" = "gscreenshot";
              };
            }
          ];
        };
      };
      menu = [
        {
          menuId = "client-menu";
          label = "Client Menu";
          icon = "";
          items = [
            {
              label = "Maximize";
              icon = "";
              action = {
                name = "ToggleMaximize";
              };
            }
            {
              label = "Fullscreen";
              action = {
                name = "ToggleFullscreen";
              };
            }
            {
              label = "Alacritty";
              action = {
                name = "Execute";
                command = "alacritty";
              };
            }
            {
              label = "Move Left";
              action = {
                name = "SendToDesktop";
                to = "left";
              };
            }
            {
              separator = { };
            }
            {
              label = "Workspace";
              menuId = "workspace";
              icon = "";
              items = [
                {
                  label = "Move Left";
                  action = {
                    name = "SendToDesktop";
                    to = "left";
                  };
                }
              ];
            }
            {
              separator = true;
            }
          ];
        }
      ];
    };
  };
}
