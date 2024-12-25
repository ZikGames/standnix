{ pkgs, lib, config, ...}: {
  environment.systemPackages = with pkgs; [
    steam-run
    steamcmd
    steam-tui
  ];
}