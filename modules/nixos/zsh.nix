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

  shellAliases = {
  };
 #   history.size = 10000;
 #   history.ignoreAllDups = true;
 #   history.path = "../configs/.zsh_history";
 #   history.ignorePatterns = ["rm *" "pkill *" "cp *"];
};
};
}
