{self, inputs, options, lib, config, ...}: {
      flake.modules.homeModules.throne = { inputs, outputs, pkgs, lib, config, ... }: {
        programs.throne = {
          package = self.packages.${pkgs.stdenv.hostPlatform.system}.throne-warp;
          enable = true;
          tunMode.enable = true;
          };
  };
  
   perSystem = { pkgs, lib, config, ...}: {
    
  packages.throne-warp = inputs.wrapper-modules.wrappers.throne.wrap {
    pkgs.throne.overrideAttrs {
      buildInputs = oldAttrs.buildInputs ++ [ pkgs.cloudflare-warp ];
      # throne-srslist = {};
    };
  };
};
}