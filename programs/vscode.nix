{ config, lib, pkgs, ... }:{
 options = {
  vscode.enable =
 lib.mkEnableOption "i use vscode btw";
 };
  config = lib.mkIf config.vscode.enable {
programs.vscode = {
  enable = true;
  package = pkgs.vscode.fhs;
  profiles.default = {
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
home.packages = with pkgs; [
blockbench
];
  };
}
