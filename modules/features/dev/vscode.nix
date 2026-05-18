{self, inputs, options, lib, config, ...}: {
flake.homeModules.vscode = { inputs, outputs, pkgs, lib, config, ... }: {
programs.vscode = {
  enable = true;
  package = pkgs.vscode-fhs;
  profiles.default = {
  extensions = with pkgs.vscode-extensions; [ 
    # sumneko.lua
    # ms-dotnettools.csharp
    # ms-dotnettools.csdevkit
    # ms-dotnettools.vscode-dotnet-runtime
    woberg.godot-dotnet-tools
    jnoortheen.nix-ide
  ];
  userSettings = {
  };
  };
};
home.packages = with pkgs; [
blockbench
];
};
}