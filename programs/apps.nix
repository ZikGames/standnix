{ config, lib, pkgs, ... }:{
 options = {
  apps.enable =
 lib.mkEnableOption "apps";
 };
  config = lib.mkIf config.apps.enable {
home.packages = with pkgs; [
      vlc
      keepassxc
      virt-manager
      (limo.override { withUnrar = true; })
      protontricks
      heroic-unwrapped
      fastfetch
      scrcpy
      archipelago
      godot-mono
      telegram-desktop
      thunderbird
      deluge
      mangohud
      ytmdesktop
      koreader
];
};
}
