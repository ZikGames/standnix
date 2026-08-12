{
  flake-file.inputs.wrappers.url = "github:lassulus/wrappers";
  flake.nixosModules.vintagestory = {
    environment.systemPackages = [
      # self.packages.${pkgs.stdenv.hostPlatform.system}.vintagestory-cwrapped
    ];
  };
}
