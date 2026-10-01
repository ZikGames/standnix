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

        just a something

        ## stand of the nix

        "бла бла бла нейросети бла бла бла... эх, слижком много я стал использовать нейронку =["
        <h5>мысли во время обновления 14.09.26</h5>

      '';
      ".gitignore".text = builtins.readFile ./gitignore;
      # "cargo.toml".text = builtins.readFile ./cargo.toml;
    };
  };

}
