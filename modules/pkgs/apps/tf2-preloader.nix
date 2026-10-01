{
  perSystem = { pkgs, ... }: {

    packages.casual-pre-loader = pkgs.callPackage (
      {
        lib,
        stdenv,
        fetchFromGitHub,
        makeWrapper,
        python3,
        qt6,
        wine,
      }:
      let
        valve-parsers = python3.pkgs.buildPythonPackage rec {
          pname = "valve-parsers";
          version = "unstable"; # pin to a real tag/rev once you check the repo
          pyproject = true;
          src = fetchFromGitHub {
            owner = "cueki";
            repo = "valve-parsers";
            rev = "main"; # replace with a pinned commit
            hash = "sha256-HZJhDQc3bbq4DQUlDR+KPB2ccuEpsaOKyUXH0Fhba7c=";
          };
          build-system = [ python3.pkgs.setuptools ];
        };

        pythonEnv = python3.withPackages (
          ps: with ps; [
            more-itertools
            packaging
            pillow
            platformdirs
            pygithub
            pyqt6
            requests
            rich
            valve-parsers
          ]
        );
      in
      stdenv.mkDerivation (finalAttrs: {
        pname = "casual-pre-loader";
        version = "2.2.1";

        src = fetchFromGitHub {
          owner = "cueki";
          repo = "casual-pre-loader";
          tag = "v${finalAttrs.version}";
          fetchSubmodules = true;
          hash = "sha256-PhY14RzOBjzSz16qtcYeOsQTsfbqkJGUPhpm4bO6ztQ=";
        };

        nativeBuildInputs = [ makeWrapper ];
        dontBuild = true;
        dontConfigure = true;

        installPhase = ''
          runHook preInstall
          mkdir -p $out/share/casual-pre-loader
          cp -r . $out/share/casual-pre-loader/
          makeWrapper ${pythonEnv}/bin/python3 $out/bin/casual-pre-loader \
            --add-flags "$out/share/casual-pre-loader/main.py" \
            --prefix PATH : "${lib.makeBinPath [ wine ]}" \
            --prefix QT_QPA_PLATFORM_PLUGIN_PATH : "${qt6.qtbase}/${qt6.qtbase.qtPluginPrefix}/platforms"
          runHook postInstall
        '';

        meta = {
          description = "TF2 particle modifications via some wizardry";
          homepage = "https://github.com/cueki/casual-pre-loader";
          license = lib.licenses.gpl3Only;
          mainProgram = "casual-pre-loader";
          platforms = lib.platforms.linux;
        };
      })
    ) { };
  };
}
