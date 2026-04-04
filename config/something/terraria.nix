{ pkgs, lib, config, ...}: 
let cfg = config.terraria; in {
  options = {
    terraria.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {  
    environment.systemPackages = with pkgs; [
  mono
  tmux
  dotnet-runtime_6
  ];
nixpkgs.config.permittedInsecurePackages = [
  "dotnet-runtime-6.0.36"
];


services.terraria = {
enable = true;
#package = pkgs.tshock;
#worldPath = "/home/zik/Piero's_Machinery.wld";
dataDir = "/srv/terraria";
maxPlayers = 6;
port = 7777;
};
};
}