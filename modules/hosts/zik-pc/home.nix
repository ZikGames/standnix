  {self, inputs, options, lib, config, ...}: {

  flake.homeModules.zik = { inputs, outputs, pkgs, lib, config, ... }:
  {
    imports = [
    # self.homeModules.prismlauncher
    # self.homeModules.keepassxc
    # self.homeModules.firefox
    # self.homeModules.discord
    # self.homeModules.throne
    # self.homeModules.vscode
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
    programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;

  ohMyZsh = {
    enable = true;
    plugins = [ "git" "vi-mode" "nix-shell" ];
    theme = "gallifrey";
  };

};
  };
  home = {
    username = "zik";
    homeDirectory = "/home/zik";
  };
  systemd.user.startServices = "sd-switch";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [ steam-run ];
  };
};
}
