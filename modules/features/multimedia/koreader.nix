{self, inputs, options, lib, config, ...}: {
flake.homeModules.koreader = {pkgs, ...}: {
  home.packages = with pkgs; [
    koreader
  ];
};
}