{self, inputs, options, lib, config, ...}: {
flake.modules.homeModules.zed = { inputs, outputs, pkgs, lib, config, ... }: {
programs.zed-editor = {
  enable = true;
  extensions = [ "nix" "toml" "rust" "csharp" "lua" "html" ];
  userSettings = {
    theme = {
      mode = "system";
      dark = "One Dark";
      light = "One Light";
    };
    hour_format = "hour24";
    vim_mode = true;
  };
};
};
}