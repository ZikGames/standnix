{

  flake.nixosModules.steam =
    {
      pkgs,
      ...
    }:
    {
      programs.steam = {
        enable = true;
        # package = pkgs.millennium-steam;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = true;
        protontricks.enable = true;
        fontPackages = with pkgs; [
          dejavu_fonts
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-color-emoji
          liberation_ttf
          raleway
          alegreya
        ];
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
        extraPackages = with pkgs; [
          mangohud
          steam-unwrapped
        ];
      };

    };
}
