{
  self,
  inputs,
  options,
  lib,
  config,
  ...
}:
{
  flake.nixosModules.g3m = { }: { };
  flake.homeModules.g3m = { }: { };
  # perSystem = { pkgs, lib, ... }: {
  #   pkgs.packages.g3m = pkgs.stdenv.mkDerivation {
  #     pname = "g3m";
  #     version = "dev";

  #     src = fetchFromGitHub {
  #       owner = "";
  #       repo = "";
  #       rev = "";
  #       sha256 = "";
  #     };

  #     buildPhase = ''

  #     '';
  #   };
  # };
}
