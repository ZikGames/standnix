{
  flake.homeModules.prismlauncher = { pkgs, ... }: {
    programs.prismlauncher = {
      enable = true;
      package = pkgs.prismlauncher.override ({
        additionalPrograms = with pkgs; [
          ffmpeg
          mangohud
          wayland
          libxkbcommon
          libinput
          wayland-protocols
        ];
        additionalLibs = with pkgs; [
          vulkan-loader
          glfw3-minecraft
          openal
          libxkbcommon
          libinput
        ];
        controllerSupport = true;
        jdks = with pkgs; [
          graalvmPackages.graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      });
    };
  };
}
