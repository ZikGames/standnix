{ lib, config, ...}: 
let cfg = config.network; in {
  options = {
    network.enable = lib.mkEnableOption "networking";
  };

  config = lib.mkIf cfg.enable {
  networking.hostName = "zik-pc";
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.wireless.enable = true;

  services.openssh = {
  enable = true;
  ports = [ 22 ];
  settings = {
  PasswordAuthentication = true;
  AllowUsers = null;
  UseDns = false;
  X11Forwarding = false;
  PermitRootLogin = "prohibit-password";
  };
 };
  };
}
