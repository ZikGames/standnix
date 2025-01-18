{pkgs, lib, config, ... }: {


 options = {
  zsh.enable =
  lib.mkEnableOption "zsh enable";
};

 config = lib.mkIf config.zsh.enable {

programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestions.enable = true;
  syntaxHighlighting.enable = true;

  ohMyZsh = {
    enable = true;
    plugins = [ "git" ];
    theme = "gallifrey";
  };

};
};
}
