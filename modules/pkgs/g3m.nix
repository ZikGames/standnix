{
  perSystem =
    { config, pkgs, ... }:
    {
      packages.g3m =
        pkgs.callPackage
          (
            {
              lib,
              python3Packages,
              fetchFromGitHub,
              playsound3,
              autoPatchelfHook,
            }:
            let
              pythonDeps = with pkgs.python3Packages; [
                defusedxml
                playsound3
                psutil
                py7zr
                pyqt6
                python-dotenv
                rarfile
                requests
                urllib3
              ];
              testDeps = with pkgs.python3Packages; [
                pytest
                pytest-cov
                pytest-html
                pytest-mock
                pytest-qt
                responses
              ];
            in
            pkgs.python3Packages.buildPythonApplication (finalAttrs: {

              pname = "g3m";
              version = "3.3.2";
              pyproject = true;
              __structuredAttrs = true;

              src = fetchFromGitHub {
                owner = "y114git";
                repo = "G3M";
                tag = finalAttrs.version;
                hash = "sha256-n2BTI0n+4CEpKu53Iq7gEdYGVQfImUFJz+75lNRJCr0=";
              };
              doCheck = true;

              build-system = [
                python3Packages.setuptools
                python3Packages.wheel
              ];

              dependencies = pythonDeps;

              optional-dependencies = with python3Packages; {
                build = [
                  pyinstaller
                ];
                dev = [
                  ruff
                ];
                test = testDeps;
              };

              # nixpkgs' pyqt6/defusedxml versions won't exactly match whatever
              # version G3M's pyproject.toml pins — this tells the build to accept
              # what's actually available instead of failing on a strict pin mismatch
              pythonRelaxDeps = [
                "PyQt6"
                "defusedxml"
                "rarfile"
              ];

              pythonImportsCheck = [ ]; # confirmed: no top-level "g3m" module — it's run as a script, not imported as a package

              nativeCheckInputs = [ python3Packages.pytestCheckHook ] ++ testDeps;

              # этот тест дёргает `git` и инспектирует закоммиченные файлы —
              # в sandbox'е нет ни .git, ни самого git, тесту там нечего делать
              disabledTests = [
                "test_removed_usage_reporting_has_no_tracked_references"
                # "test_background_audio_pause_detection_accepts_child_windows"
                # "test_search_mod_card_widget_expands_on_selection_and_hides_on_focus_loss"
              ];
              # devShells.default = pkgs.mkShell {
              #   # Drops you into a Python environment containing all production and testing dependencies
              #   packages = [
              #     (pkgs.python3.withPackages (ps: pythonDeps ++ testDeps))
              #   ];
              # };
              # pytest-qt/PyQt6 без экрана падают — нужен offscreen-плагин Qt
              # preCheck = ''
              #   export QT_QPA_PLATFORM=offscreen
              #   export HOME=$(mktemp -d)
              # '';

              nativeBuildInputs = [
                pkgs.makeWrapper
                # G3MTool — сторонний бинарник, бандлится в assets/bin/g3mtool_linux/.
                # На NixOS у него неправильный ELF-интерпретатор/rpath —
                # autoPatchelfHook чинит это автоматически на fixupPhase.
                autoPatchelfHook
              ];

              # buildPythonApplication has nothing to auto-generate bin/g3m from,
              # since G3M has no [project.scripts] entry point (its own README
              # runs it via `python src/main.py`, not an installed command).
              # Find main.py wherever the build backend actually placed it
              # (turned out to be app/window/main.py, not src/main.py).
              #
              # A plain `makeWrapper <interpreter> $out/bin/g3m --add-flags main_py`
              # was tried first, but that bypasses buildPythonApplication's own
              # dependency wiring entirely — its automatic PYTHONPATH injection
              # only patches scripts it recognizes as Python entry points, and a
              # hand-rolled makeWrapper shell script isn't one, which is why
              # PyQt6 (and everything else in `dependencies`) built fine but
              # wasn't importable at runtime. Fix: set PYTHONPATH explicitly
              # using the same makePythonPath helper wrapPython uses internally.
              postInstall = ''
                # setuptools packages.find подхватывает только пакеты (директории) —
                # assets/иконки/темы/языки, config/qss и сторонний бинарник
                # G3MTool не являются python-пакетами и в wheel не попадают.
                # Копируем весь src/ поверх site-packages как есть (cp -a
                # сохраняет права доступа, в т.ч. +x у G3MTool).
                cp -a src/. "$out/${python3Packages.python.sitePackages}/"

                main_py=$(find "$out/${python3Packages.python.sitePackages}" -maxdepth 4 -name main.py -print -quit)
                if [ -z "$main_py" ]; then
                  echo "g3m: could not locate main.py under site-packages" >&2
                  exit 1
                fi

                makeWrapper ${python3Packages.python.interpreter} "$out/bin/g3m" \
                  --add-flags "$main_py" \
                  --set PYTHONPATH "$out/${python3Packages.python.sitePackages}:${python3Packages.makePythonPath pythonDeps}" \
                  --prefix PATH : ${
                    pkgs.lib.makeBinPath [
                      pkgs.ffmpeg-full
                      pkgs.alsa-utils
                      pkgs.gst_all_1.gstreamer
                      pkgs.gst_all_1.gst-plugins-base
                    ]
                  }
              '';

              meta = {
                description = "Mod Manager for GameMaker games";
                homepage = "https://github.com/y114git/G3M";
                changelog = "https://github.com/y114git/G3M/blob/${finalAttrs.src.rev}/CHANGELOG.md";
                license = lib.licenses.gpl3Plus;
                mainProgram = "g3m";
              };
            })
          )
          {
            inherit (config.packages) playsound3; # this is the bridge — callPackage can't see it otherwise
          };
    };
}
