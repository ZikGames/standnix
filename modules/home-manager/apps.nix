{ lib, config, pkgs, ... }:
 
let cfg = config.apps; in {
  options = {
    apps.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    ## работа с файлами
     ranger
     #xarchiver
     #mucommander
     #tuifimanager
      # nnn
       felix-fm

    ## майнкрафт
    blockbench
    vscode
    prismlauncher-unwrapped

    ## интернет
    obs-studio
    deluge-gtk
    telegram-desktop

  ## системное
  #neofetch
  fastfetch
  zenith
  htop-vim
  
  ## игры
# pcsx2
# rpcs3
  doomretro
  openmw
  
    ## консольная солянка
  #   chess-tui
  #   tg
  #   discordo
  #   cl-wordle
  #   dooit
  #   tuir
  #   youtube-tui
  #   textual-paint
  #   termusic

    ## чёто
  #   libresprite
  #   clamav
  #   clamtk
  #   flameshot
];
programs.neovim = {
   enable = true;
   defaultEditor = true;
};

};
}
