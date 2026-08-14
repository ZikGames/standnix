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

        результаты мозгового штурма с применением ии:

        плюсы

        + (полу)рабочий bun-baseline

        + G3M успешно запускается с учётом либов (но без G3MTool и при скачивании deltamod модов всё ещё вылетает, но моды успешно ставятся)

        + git hooks, files

        минусы

        - осознание что я немощь

        - steam-millenium досихпор не работает, несмотря на bun-baseline, который с equibop работает

        - отчасти понимаю как поставить cueki casual preloader, но мне лень

        - сломал свою конфигурацию Zed Editor

      '';
      ".gitignore".text = builtins.readFile ./gitignore;
      # "cargo.toml".text = builtins.readFile ./cargo.toml;
    };
  };

}
