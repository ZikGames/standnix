{ config, lib, pkgs, ... }:{
 options = {
  apps.enable =
 lib.mkEnableOption "apps";
 };
  config = lib.mkIf config.apps.enable {
home.packages = with pkgs; [
      appimage-run
      vlc
      keepassxc
      virt-manager
      (limo.override { withUnrar = true; })
      protontricks
      heroic-unwrapped
      umu-launcher
      fastfetch
      scrcpy
      tree
      archipelago
      godot_4_4-mono
      telegram-desktop
      thunderbird
      deluge
      mangohud
];
};
}
