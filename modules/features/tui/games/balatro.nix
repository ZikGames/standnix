{
  flake-file.inputs.balatroTUI = {
    url = "github:Passeriform/balatroTUI";
  };
  flake.homeModules.balatroTUI = { pkgs, ... }: {
    home.packages = with pkgs; [ balatroTUI ];
  };
}
