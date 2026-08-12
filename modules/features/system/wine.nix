{
  flake.nixosModules.wine = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      wineWow64Packages.waylandFull
      wine
    ];

  };
}
