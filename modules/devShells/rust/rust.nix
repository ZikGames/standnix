{self, inputs, options, lib, config, ...}: {
  # flake.nixosModules.rust = {pkgs, lib, imports, ...}: {
  # imports = [

  # ];
  # };
  perSystem = { config, lib, self, ... }: {
    rust-project = {
      src = self;
      crates = {
        dnd-helper = {
          path = ./dnd-helper;
        };
      };
    };
  };
}
