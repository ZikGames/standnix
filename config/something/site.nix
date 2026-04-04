{ pkgs, lib, config, ...}: 
let cfg = config.site; in {
  options = {
    site.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {  
    
    services.nginx = {
  enable = true;
  additionalModules = with pkgs; [
    nginxModules.dav
  #  nginxModules.lua
   ];
  virtualHosts."selfhost.zkdl.su" = {
    root = "/srv/www/zkdl.su";
  };
};
   environment.systemPackages = with pkgs; [
      luajit_openresty
      luajit_2_0
      luajitPackages.lua-resty-core
  ];
};
}