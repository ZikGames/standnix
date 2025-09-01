{ config, lib, pkgs, ... }:

let
  cfg = config.services.vscode;
in
{
  options.services.vscode = {
    enable = lib.mkEnableOption "vscode + blockbench";
  };

  config = lib.mkIf cfg.enable {
programs.vscode = {
  enable = true;
  package = pkgs.vscode.fhs;
  extensions = with pkgs.vscode-extensions; [ 
    sumneko.lua
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    woberg.godot-dotnet-tools
    jnoortheen.nix-ide
  ];
  userSettings = {
    # Custom settings
  };
};
  };
}