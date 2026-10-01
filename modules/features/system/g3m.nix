{
  flake-file.inputs = {
    g3m.url = "github:ZikGames/G3M/python-nix";
  };
  flake.nixosModules.g3m = { pkgs, inputs, ... }: {
    imports = [ inputs.g3m.nixosModules.default ];
    programs.g3m = {
      enable = true;
      package = inputs.g3m.packages.${pkgs.system}.g3m;
    };
  };
}
