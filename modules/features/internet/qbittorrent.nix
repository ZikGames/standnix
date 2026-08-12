{
  flake.nixosModules.qbittorrent = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      qbittorrent
    ];
    # services.qbittorrent = {
    # enable = true;
    # user = "zik";
    # };
  };
}
