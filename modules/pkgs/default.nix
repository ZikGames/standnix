{ self, ... }:
{
  perSystem = { config, pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      inputsFrom = [ config.pre-commit.devShell ];
    };
  };

  flake.nixosModules.standnixpkgs = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.system}.deltarune
      pkgs.nix-output-monitor

      # self.packages.${pkgs.system}.tf2-preloader
    ];
  };
}
