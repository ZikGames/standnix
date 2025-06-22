{ lib, config, ...}: 
let cfg = config.pipewire; in {
  options = {
    pipewire.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {


  services.pulseaudio.enable = false;
  hardware.pulseaudio.support32Bit = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
};
  }
