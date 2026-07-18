{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.labwc = { pkgs, lib, ... }: {
    programs.labwc.enable = true;
    environment.systemPackages = with pkgs; [
      wl-clipboard
      grim
      labwc-tweaks-gtk
      dracula-theme
      dracula-icon-theme
      qogir-theme
      qogir-icon-theme
      alacritty
      pcmanfm
      gscreenshot
      self.packages.${pkgs.stdenv.hostPlatform.system}.noctalia-cwrapped
    ];
  };
  flake.homeModules.labwc = {
    wayland.windowManager.labwc = {
      autostart = [
        "noctalia-shell &"
      ];
      environment = [
        "XDG_CURRENT_DESKTOP=labwc:wlroots"
        "XKB_DEFAULT_LAYOUT=us,ru"
      ];
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
