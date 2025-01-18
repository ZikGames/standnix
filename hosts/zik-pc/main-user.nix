{ lib, config, pkgs, ... }:

let
  cfg = config.main-user;
in
{
  options.main-user = {
    enable
      = lib.mkEnableOption "enable user module";

    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
  services.getty.autologinUser = "${cfg.userName}";
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initialPassword = "121312";
      description = "zik";
      extraGroups = [ "networkmanager" "wheel" "adbusers" "sudoers"];
      shell = pkgs.zsh;
    };
  };
}
