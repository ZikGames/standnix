{ self, inputs, ... }: {
  flake.flake-file.inputs.wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";
  perSystem = { pkgs, ... }: {

    packages.noctalia-cwrapped = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
      inherit pkgs;
      settings = (builtins.fromJSON (builtins.readFile ./noctalia.json)).settings;
    };
  };
}
