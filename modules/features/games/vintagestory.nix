{self, inputs, options, lib, config, ...}: {
  flake-file.inputs.wrappers.url = "github:lassulus/wrappers";
  flake.nixosModules.vintagestory = {pkgs, ...}: {
    environment.systemPackages = [
      # self.packages.${pkgs.stdenv.hostPlatform.system}.vintagestory-cwrapped
    ];
  };
  perSystem = { pkgs, lib, wrappers, ...}: {

#     packages.vintagestory-cwrapped = inputs.wrappers.lib.wrapPackage {
#   inherit pkgs;
#   package = pkgs.vintagestory;
#   exePath = "./Playvintagestory";
#   binName = "playvintagestory";
# };

  };
}