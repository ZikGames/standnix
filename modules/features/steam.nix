{self, inputs, pkgs, system, config, ...}: {
  flake-file.inputs.millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
  perSystem = { system, pkgs, overlays, final, ... }: { 
   _module.args.pkgs = import inputs.nixpkgs {
    inherit system;
    overlays = [
    inputs.millennium.overlays.default
    ];
    config = { };
  };
};
  flake.nixosModules.steam = { inputs, outputs, pkgs, lib, config, system, ... }:
  {
  programs.steam = {
  enable = true;
  # package = pkgs.millennium-steam;
  remotePlay.openFirewall = true; 
  dedicatedServer.openFirewall = true;
  localNetworkGameTransfers.openFirewall = true;
  gamescopeSession.enable = true;
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