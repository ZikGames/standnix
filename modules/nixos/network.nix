{ lib, config, options, ...}: 
let cfg = config.network; in {
  options = {
    network.enable = lib.mkEnableOption "networking";
  };

  config = lib.mkIf cfg.enable {
#  networking.hostName = "zik-pc";
  hardware.bluetooth.enable = true;
  networking.wireless.iwd.enable = true;
  networking = {
    hostName = "zik-pc";
    interfaces.wlan0 = {
      useDHCP = false;
      ipv4.addresses = [{
    address = "62.183.96.183";
    prefixLength = 24;  
  }];
   };
     nameservers = [ "77.88.8.8" "77.88.8.1" ];
     defaultGateway = "192.168.0.1";
    # wireless = {
    #   enable = true;
    #   interfaces = ["wlp3s0"];
    #   networks = {
    #     he-mnie = {
    #       psk = "32412wdsa";
    #     };
    #   };
    # };
  };
  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
  PasswordAuthentication = true;
  AllowUsers = null;
  UseDns = false;
  X11Forwarding = true;
  PermitRootLogin = "prohibit-password";
  };
 };
  };
}