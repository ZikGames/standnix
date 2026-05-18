{self, inputs, options, lib, config, ...}: {
  flake.homeModules.prismlauncher = { pkgs, lib, ...}: {
  #   programs.prismlauncher = {
  #   enable = true;
  # };
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
