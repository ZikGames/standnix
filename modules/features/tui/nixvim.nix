{
  flake-file.inputs.nixvim.url = "github:nix-community/nixvim";
  flake.nixosModules.nixvim = {
    programs.nixvim = {
      enable = true;

      colorschemes.catppuccin.enable = true;
      plugins.lualine.enable = true;
    };
  };
}
