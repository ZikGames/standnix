{ pkgs, lib, config, ...}: 
let cfg = config.labwc; in {
  options = {
    labwc.enable = lib.mkEnableOption "Enable Module";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      swaylock
      swayidle
      wl-clipboard
      wf-recorder
      mako
      grim
     #kanshi
      slurp
      alacritty
      wofi
      sfwbar
      labwc-tweaks-gtk
      labwc-gtktheme
      swaybg
	  wmenu
	  dunst
	python3
	blueman
	mission-center
	sfm
    ];

    fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-cjk-sans
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts.githubRelease
  dina-font
  proggyfonts
  roboto
  dejavu_fonts
];

    
  programs.labwc = {
    enable = true;
  };
};
  }
