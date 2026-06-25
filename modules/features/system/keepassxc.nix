{ self, inputs, ... }:
{
  flake.homeModules.keepassxc =
    {
      inputs,
      outputs,
      pkgs,
      lib,
      config,
      ...
    }:
    {
      programs.git-credential-keepassxc = {
        enable = true;
        hosts = [ "https://github.com" ];
      };
      programs.keepassxc = {
        enable = true;
        autostart = true;
        settings = {
          Browser.Enabled = true;

          GUI = {
            AdvancedSettings = true;
            ApplicationTheme = "dark";
            CompactMode = true;
            HidePasswords = true;
          };

          FdoSecrets.Enabled = true; # Enable Secret Service Integration
          SSHAgent.Enabled = true;
        };
      };
      xdg.autostart.enable = true;
    };
}
