{ config, lib, pkgs, ... }:{
 options = {
  prismlauncher.enable =
 lib.mkEnableOption "the best minecraft launcher";
 };
  config = lib.mkIf config.prismlauncher.enable {
    home.packages = with pkgs; [
    (prismlauncher.override {
    additionalPrograms = [ ffmpeg mangohud ];
    additionalLibs = [vulkan-loader glfw3-minecraft openal];
    controllerSupport = true;
    jdks = [
     graalvmPackages.graalvm-ce
      zulu8
      zulu17
      zulu
    ];
  })
    ];
  };
}