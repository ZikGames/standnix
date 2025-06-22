{pkgs, lib, config, ... }: {


 options = {
  wine.enable =
  lib.mkEnableOption "wine";
};

 config = lib.mkIf config.wine.enable
{
environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
  #  protonplus
    protontricks
    bottles
];
};
}