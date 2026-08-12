{
  flake.homeModules.koreader = { pkgs, ... }: {
    home.packages = with pkgs; [
      koreader
    ];
  };
}
