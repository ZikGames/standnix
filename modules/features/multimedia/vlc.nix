{
  flake.homeModules.vlc = { pkgs, ... }: {
    home.packages = with pkgs; [
      vlc
    ];
  };
}
