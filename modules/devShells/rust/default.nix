{self, inputs, options, lib, config, ...}: {
  # flake.nixosModules.rust = {pkgs, lib, imports, ...}: {
  # imports = [

  # ];
  # };
  perSystem = { config, lib, self', ... }: {
    rust-project = {
      # src =  ./modules/devShells/rust;
      src = ./.;
      # cargoToml = "./modules/devShells/rust/cargo.toml";
      # crateNixFile = "crate.nix";
      crates = {
        dnd-helper = {
          # path = ./modules/devShells/rust/dnd-helper;
          path = ./dnd
        };
      };
    };
    devShells.rust = self'.devShells.rust;
  };
}
