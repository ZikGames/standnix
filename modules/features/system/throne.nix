{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.throne = { inputs, outputs, pkgs, lib, config, ... }: {
    services.cloudflare-warp.enable = true;
    programs.throne = {
      # package = self.packages.${pkgs.stdenv.hostPlatform.system}.throne-warp;
      enable = true;
      tunMode.enable = true;
    };
  };
  
#   perSystem = { pkgs, lib, config, ...}: {
    
#   packages.throne-warp = wrappers.lib.wrapPackage {
#   inherit pkgs;
#   package = pkgs.throne;
#   runtimeInputs = [ pkgs.jq ];
#   env = {

#   };
#   flags = {
#     "--silent" = true;
#     "--connect-timeout" = "30";
#   };
#   # Or use args directly for more control:
#   # args = [ "--silent" "--connect-timeout" "30" ];
#   flagSeparator = "=";  # Use --flag=value instead of --flag value (default is " ")
#   preHook = ''

#   '';
# };
# };
}