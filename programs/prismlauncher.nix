  { config, lib, pkgs, ... }:

let
  cfg = config.services.prismlauncher;
in
{
  options.services.prismlauncher = {
    enable = lib.mkEnableOption "prism launcher";
  };

  config = lib.mkIf cfg.enable {
      (prismlauncher.override {
    # Add binary required by some mod
    additionalPrograms = [ ffmpeg  ];
    additionalLibs = [vulkan-loader glfw3-minecraft openal];
    controllerSupport = true;

    # Change Java runtimes available to Prism Launcher
    jdks = [
      graalvm-ce
      zulu8
      zulu17
      zulu23
      zulu
    ];
  })
  };
}