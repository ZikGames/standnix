{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.throne = { inputs, outputs, pkgs, lib, config, ... }: {
    programs.throne = {
      # package = self.packages.${pkgs.stdenv.hostPlatform.system}.throne-resource;
      enable = true;
      tunMode.enable = true;
    };
  };
  
  perSystem = { pkgs, lib, config, ...}: {
    
  # packages.throne-resource = pkgs.throne.overrideAttrs (oldAttrs: rec {
  #         version = "dev";
          
  #         src = pkgs.fetchFromGitHub {
  #           owner = "throneproj";
  #           repo = "Throne";
  #           rev = "f34bd89";
  #           hash = "f34bd8966f8943dad199c13e8ed64531b4d20f31"; 
  #         };
  #       });
};
}