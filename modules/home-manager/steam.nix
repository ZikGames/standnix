{pkgs, lib, config, ...}: {
 options = {
  steam.enable =
 lib.mkEnableOption "steam enable";
 };
 config = lib.mkIf config.steam.enable {
};
}
