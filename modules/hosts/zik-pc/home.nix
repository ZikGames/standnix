  {self, inputs, options, lib, config, ...}: {  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeModules.zik = { inputs, outputs, pkgs, lib, config, ... }:
  {
    imports = [
    self.homeModules.prismlauncher
    self.homeModules.keepassxc
    self.homeModules.firefox
    self.homeModules.discord
    self.homeModules.labwc
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = /home/zik/standnix;


  programs.git = {
    enable = true;
    settings.user = {
    name = "Zik1213";
    email = "zik1213@outlook.com";
  };
  };

  home = {
    username = "zik";
    homeDirectory = "/home/zik";
  };
  home.packages = with pkgs; [ steam-run ];
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";
  };
};
}