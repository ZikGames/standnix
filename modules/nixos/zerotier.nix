{pkgs, lib, config, ... }: {


 options ={
  zerotier.enable =
  lib.mkEnableOption "zerotier enable";
};

 config = lib.mkIf config.zerotier.enable {

   services.zerotierone = {
     enable = true;
     joinNetworks = [
    "fada62b0154ed26c"
    "af415e486f3487c3"    
    ];
  };

};
}
