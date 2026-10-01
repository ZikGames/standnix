{ self, ... }: {
  flake.nixosModules.x11 =
    {
      ...
    }:
    {
      imports = [
        self.nixosModules.windowmaker
        # self.nixosModules.dwm
      ];
      services.xserver = {
        enable = true;
        xkb.layout = "us,ru";
        xkb.options = "grp:shift_alt_toggle";
      };
    };

}
