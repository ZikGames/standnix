{self, inputs, options, lib, config, ...}: {
flake.homeModules.vlc = {pkgs, ...}: {
  home.packages = with pkgs; [
    vlc
  ];
};
}