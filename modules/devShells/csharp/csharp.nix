{self, inputs, options, lib, config, ...}: {
  flake.nixosModules.CSharp = {pkgs, lib, imports, ...}: {
  environment.sessionVariables = {
  DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };
      # devShells = forEachSupportedSystem (
  };
  perSystem = {pkgs, lib, imports, ...}: {
  devShells.CSharp = { pkgs }:
    {
      default = pkgs.mkShell {
      packages = with pkgs; [
        dotnet-sdk_10
        omnisharp-roslyn
        mono
        msbuild
      ];
      };
    src = ./.;
        };
    };
}
