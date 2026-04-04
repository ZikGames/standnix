{ config, lib, pkgs, ... }:{
 options = {
  vscode.enable =
 lib.mkEnableOption "i use vscode btw";
 };
  config = lib.mkIf config.vscode.enable {
programs.vscode = {
  enable = true;
  package = pkgs.vscode-fhs;
  profiles.default = {
  extensions = with pkgs.vscode-extensions; [ 
    sumneko.lua
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
    ms-dotnettools.vscode-dotnet-runtime
    woberg.godot-dotnet-tools
    jnoortheen.nix-ide
  ];
  userSettings = {
  };
  };
};
home.packages = with pkgs; [
blockbench
dotnet-runtime_9
dotnet-sdk_9
];
  };
}
