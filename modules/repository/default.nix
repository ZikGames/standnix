{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  # flake = {
  #   flake-files.inputs.files = {
  #     url = "github:mightyiam/files";
  #     flake = false;
  #   };
  #   imports = [
  #     "${inputs.files}/flake-module.nix"
  #   ];
  # };
  # perSystem = {

  #   files.file = {
  #     gitToplevel = "../../.";
  #     "README.md".text = ''
  #         # standnix

  #         ## stand of the nix

  #       something
  #     '';
  #     ".gitignore".source = ./gitignore;
  #     "cargo.toml".source = ./cargo.toml;
  #   };
  # };
}
