{ lib, config, pkgs, assertions, ... }:
 
let cfg = config.apps; in {
  options = {
    apps.enable = lib.mkEnableOption "Enable Module";
  };
   config = lib.mkIf cfg.enable {
  home.packages = with pkgs; [
    ## работа с файлами
  #  ranger
  #  pcmanfm
  #  xarchiver
  #  commander
  #  tuifimanager
  #  nautilus
  #   nnn
  #   felix-fm
  #  spaceFM
  #  xfe
  #    chafa
  #    bat
	filezilla
    mangohud

    ## майнкрафт
    blockbench
    vscode
      (prismlauncher.override {
    # Add binary required by some mod
    additionalPrograms = [ ffmpeg  ];
    additionalLibs = [vulkan-loader glfw3-minecraft openal   nspr nss at-spi2-core libxkbcommon];
    controllerSupport = true;

    # Change Java runtimes available to Prism Launcher
    jdks = [
      graalvm-ce
      zulu8
      zulu17
      zulu23
      zulu
    ];
  })

    ## интернет
    obs-studio
    deluge-gtk
    telegram-desktop
      #  nitter
    firefox
      #yandex-disk
      #yandex-music

  ## системное
  fastfetch
 # zenith
 # htop-vim
 # gscreenshot
  vlc
  
  ## игры
# pcsx2
# rpcs3
  doomretro
  openmw
  srb2
  limo
  archipelago
  godot
  
    ## консольная солянка
  #   chess-tui
  #   tg
     discordo
     cl-wordle
     dooit
     tuir
     youtube-tui
  #   textual-paint
  #   termusic
      t
      tuisky
      tuifeed
  #    hiddify-app
      ruby
  #    browsh

    ## чёто
  #   libresprite
  #   clamav
  #   clamtk
  #   flameshot
  #   thunderbird
#  qdirstat
#  gparted
keepassxc
];
};
}
