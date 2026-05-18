{self, inputs, options, lib, config, ...}: {
  # flake.nixosModules.rust = {pkgs, lib, imports, ...}: {
  # imports = [

  # ];
  # };
  perSystem.rust-project = {
    src = ./.;
    crates = {
      dnd-helper = {
        path = ./dnd-helper;
      };
    };
  };
}
