{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.obs;
in
{
  options.obs = {
    enable = mkEnableOption "Enable DPI (Deep Packet Inspection) bypass";
  };

  config = mkIf cfg.enable {
  
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      # obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture

    ];
  };  
  };
}
