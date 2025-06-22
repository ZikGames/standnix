{ pkgs, lib, config, ...}:
let cfg = config.android; in {
  options = {
    android.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
	scrcpy
#	qtscrcpy
	];
  programs.adb = {
   enable = true;
};
};
}
