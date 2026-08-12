{
  inputs,
  ...
}:
{
  flake-file.inputs.files.url = "github:mightyiam/files";
  flake-file.inputs.files.flake = false;
  imports = [ "${inputs.files}/flake-module.nix" ];

  perSystem = {
    files.writer.app = true;
    files.file = {
      "README.md".text = ''
        # standnix

        ## stand of the nix

        Nyeh heh heh!
      '';
      ".gitignore".text = builtins.readFile ./gitignore;
      "cargo.toml".text = builtins.readFile ./cargo.toml;
    };
  };

}
