{ config, lib, pkgs, ... }:{
 options = {
  prismlauncher.enable =
 lib.mkEnableOption "the best minecraft launcher";
 };
  config = lib.mkIf config.prismlauncher.enable {
    home.packages = with pkgs; [
    (prismlauncher.override {
    # Add binary required by some mod
    additionalPrograms = [ ffmpeg mangohud ];
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
    ];
  };
}