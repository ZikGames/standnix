{ self, inputs, ... }:
{
  flake.homeModules.keepassxc = { inputs, outputs, pkgs, lib, config, ... }: {
  programs.keepassxc = {
  enable = true;
  autostart = true;
    settings = {
      FdoSecrets.Enabled = true; # Enable Secret Service Integration
    };
  };
    xdg.autostart.enable = true;
  };
}