{ lib, config, pkgs, ... }:
 
let cfg = config.apps; in {
  options = {
    apps.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
     prismlauncher
     openmw
     ranger
     
     tuifimanager
     helvum
  #   chess-tui
  #   felix
  #   vim
  #   cl-wordle
   #  clamav
   #  clamtk
   #  dooit
   #  tuir
   #  youtube-tui
   #  textual-paint
   #  libresprite
   #  termusic
];
programs.vscode = {
  enable = true;
};

};
}
