{lib, pkgs, options, ...}:
{
 services.v2raya = {
  enable = true;
  cliPackage = pkgs.xray;
 };
}