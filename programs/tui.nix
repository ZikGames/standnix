{ config, lib, pkgs, ... }:{
 options = {
  tui.enable =
 lib.mkEnableOption "cli-tui-apps";
 };
  config = lib.mkIf config.tui.enable {
home.packages = with pkgs; [
    tree
    ranger
    tuir
    tuisky
    discordo
    cl-wordle
];
};
}
