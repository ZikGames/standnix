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
  };
};
}