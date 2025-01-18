{pkgs, lib, config, ... }: {


 options ={
  x11.enable =
  lib.mkEnableOption "x11 enable";
};

 config = lib.mkIf config.x11.enable {


  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "zik";
  services.xserver = {
    layout = "ru";
    xkbVariant = "";
  };

};
}
