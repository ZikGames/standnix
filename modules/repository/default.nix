{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  perSystem = { pkgs, lib, ... }: {
    files.file = {
      "README.md".text = ''
          # standnix

          ## stand of the nix

        something
      '';
      ".gitignore".source = ./.gitignore;
      "cargo.toml".source = ./cargo.toml;
    };
  };
}
