{
  flake.homeModules.ytmdesktop = { pkgs, ... }: {
    home.packages = with pkgs; [
      ytmdesktop
    ];
  };
}
