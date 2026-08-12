{
  flake.nixosModules.nitter = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      nitter
    ];
    services.nitter = {
      enable = false;

    };
  };
}
