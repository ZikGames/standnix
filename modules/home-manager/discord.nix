{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
     vesktop 

    (discord-canary.override {
     withOpenASAR = true;
     withVencord = true;
    })
  ];
}