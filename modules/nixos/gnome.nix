{pkgs, options, config, lib, ...} :
{
 options = {
  gnome.enable =
 lib.mkEnableOption "GNOME";
 };
  config = lib.mkIf config.gnome.enable {
services = {
  displayManager.gdm.enable = true;
  desktopManager.gnome = {
enable = true;
  };
gnome = {
gnome-online-accounts.enable = true;
gnome-browser-connector.enable = true;
gnome-settings-daemon.enable = true;
core-apps.enable = true;
core-os-services.enable = true;
gnome-keyring.enable = true;
  };
};
environment.gnome.excludePackages = (with pkgs; [
  atomix # puzzle game
  cheese # webcam tool
  epiphany # web browser
  evince # document viewer
  geary # email reader
  gedit # text editor
  gnome-text-editor
  gnome-characters
  gnome-music
  gnome-photos
  gnome-terminal
  gnome-tour
  hitori # sudoku game
  iagno # go game
  tali # poker game
  totem # video player
]);
programs.kdeconnect = {
  enable = true;
  package = pkgs.gnomeExtensions.gsconnect;
};
};
}
