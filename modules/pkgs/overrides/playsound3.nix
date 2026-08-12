{
  perSystem =
    { pkgs, ... }:
    let
      playsound3 = pkgs.python3Packages.callPackage (
        {
          lib,
          buildPythonPackage,
          fetchPypi,
          hatchling,
          gst_all_1,
        }:
        buildPythonPackage rec {
          pname = "playsound3";
          version = "3.3.1";
          pyproject = true;

          src = fetchPypi {
            inherit pname version;
            hash = "sha256-Pw64fV/yBh0HZjxLAQuOfWbCdDRHErAdVhoKc0R+9B0=";
          };

          build-system = [ hatchling ];
          pythonImportsCheck = [ "playsound3" ];

          # playsound3 на Linux вызывает системный `gst-play-1.0` как
          # subprocess-бэкенд для проигрывания звука — без него получите
          # "No supported audio backends on this system!" в рантайме,
          # даже если сам пакет собрался и импортируется нормально.
          propagatedBuildInputs = [ gst_all_1.gst-plugins-base ];

          meta = {
            description = "Cross platform library to play sound files in Python";
            homepage = "https://github.com/szmikler/playsound3";
            license = lib.licenses.mit;
          };
        }
      ) { };
    in
    {
      packages.playsound3 = playsound3;

      overlayAttrs.pythonPackagesExtensions = [
        (_final: _prev: { inherit playsound3; })
      ];
    };
}
