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
      limo
      archipelago
      godot_4_4-mono
      telegram-desktop
      thunderbird
];
};
}