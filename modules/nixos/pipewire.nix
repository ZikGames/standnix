{ lib, config, ...}: 
let cfg = config.pipewire; in {
  options = {
    pipewire.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {


  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
};
  }