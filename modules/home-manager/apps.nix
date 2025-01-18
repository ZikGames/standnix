{ lib, config, pkgs, ... }:
 
let cfg = config.apps; in {
  options = {
    apps.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
     prismlauncher-unwrapped
     openmw
     ranger
     xarchiver
     pavucontrol
     
     tuifimanager
    blockbench
    vscode
  #   chess-tui
  #   felix
  #   cl-wordle
   #  clamav
   #  clamtk
   #  dooit
   #  tuir
  #   youtube-tui
  #   textual-paint
  #   libresprite
   #  termusic
   obs-studio
  # pcsx2
  # rpcs3
   deluge-gtk
  # nnn
  mucommander
  telegram-desktop
  doomretro
  tg
  discordo
  flameshot
  neofetch
  vscode
];
programs.neovim = {
   enable = true;
   defaultEditor = true;
};

};
}
