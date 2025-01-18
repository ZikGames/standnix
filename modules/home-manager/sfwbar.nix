{ lib, config, pkgs, ... }:
 
let cfg = config.sfwbar; in {
  options = {
    sfwbar.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
	python3
    sfwbar
];

};
}