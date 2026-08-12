{
  flake.nixosModules.waydroid = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.waydroid-helper ];

    systemd = {
      packages = [ pkgs.waydroid-helper ];
      services.waydroid-mount.wantedBy = [ "multi-user.target" ];
    };
    virtualisation.waydroid = {
      enable = true;
      package = pkgs.waydroid-nftables;
    };
  };
}
