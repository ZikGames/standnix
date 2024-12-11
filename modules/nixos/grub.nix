{pkgs, lib, config, ...}: {
 options = {
  grub.enable =
 lib.mkEnableOption "grub enable";
 };
  config = lib.mkIf config.grub.enable {
    boot.loader = {

  efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
    };

  grub = {
     efiSupport = true;
     device = "nodev";

     };
};
 };
 }
