{self, inputs, lib, config, ...}: {
  perSystem.devShells.cSharp = { pkgs, lib, ...}: {
      buildInputs = with pkgs; [
      dotnetCorePackages.sdk_9_0_1xx-bin dotnetCorePackages.runtime_9_0-bin dotnetCorePackages.runtime_10_0-bin dotnetPackages.Nuget avalonia gtk3 webkitgtk_4_1
      ];
    nativeBuildInputs = [ pkgs.pkg-config ];
  };
}