{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./home-integration.nix
      ./main-user.nix
    ];

  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
      virtualisation.vmware.guest.enable = true;
  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
     font = "cyr-sun16";
     keyMap = "ruwin_alt_sh-UTF-8";
   };

  main-user.enable = true;
  main-user.userName = "zik";

system.stateVersion = "24.05";

}
