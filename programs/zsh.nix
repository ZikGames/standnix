{ config, lib, pkgs, ... }:

let
  cfg = config.services.zsh;
in
{
  options.services.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    dotDir = "./../configs/zsh/"; 

    shellAliases = {
      ll = "ls -la";
      ls = "ls --color=auto";
    };

    history = {
      size = 10000;
      save = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    initExtra = ''
      # Ваши кастомные настройки для .zshrc
      bindkey "^[[A" history-substring-search-up
      bindkey "^[[B" history-substring-search-down
    '';
  };
  };
}