{ pkgs, lib, config, ...}:
let cfg = config.waydroid; in {
  options = {
    waydroid.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
	scrcpy
	];
   # virtualisation.waydroid.enable = true;

  programs.adb = {
   enable = true;
};
};
}
