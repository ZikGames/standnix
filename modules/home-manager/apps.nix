{ lib, config, pkgs, ... }:
 
let cfg = config.apps; in {
  options = {
    apps.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
     prismlauncher
     openmw
     steam-run
     discordo
     ranger
     steam-tui
     clamav
     clamtk
     dooit
     tuir
     youtube-tui
    # textual-paint
     libresprite
     termusic
     
     tuifimanager
     chess-tui
     felix
     vim
     cl-wordle
];
};
}
