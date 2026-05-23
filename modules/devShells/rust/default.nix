{self, inputs, options, lib, config, ...}: {
  # flake.nixosModules.rust = {pkgs, lib, imports, ...}: {
  # imports = [

  # ];
  # };
  perSystem = { config, lib, self, ... }: {
    rust-project = {
      src =  ./modules/devShells/rust;
      crateNixFile = "crate.nix";
      crates = {
        dnd-helper = {
          path = ./dnd-helper;
          cargoToml = ./dnd-helper/Cargo.toml;
        };
      };
    };
  };
}
