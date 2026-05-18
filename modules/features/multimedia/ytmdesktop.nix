{self, inputs, options, lib, config, ...}: {
flake.homeModules.ytmdesktop = {pkgs, ...}: {
 home.packages = with pkgs; [
  ytmdesktop
 ];
};
}