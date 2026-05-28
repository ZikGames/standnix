{self, inputs, options, lib, config, ...}: {
  flake-file.inputs.wrappers.url = "github:lassulus/wrappers";
  flake.nixosModules.vintagestory = {pkgs, ...}: {
    environment.systemPackages = [
      # self.packages.${pkgs.stdenv.hostPlatform.system}.vintagestory-cwrapped
    ];
  };
}