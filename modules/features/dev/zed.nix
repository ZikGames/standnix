{
  flake.homeModules.zed =
    {
      pkgs,
      lib,
      ...
    }:
    {
      programs.zed-editor = {
        enable = true;
        extraPackages = with pkgs; [
          openssl
          zlib
          rust-analyzer
          cargo
          nixd
          nixfmt
          nodejs
          nix-ld
        ];
        # This populates the userSettings "auto_install_extensions"
        extensions = [
          "nix"
          "toml"
          "rust"
          "make"
          "lua"
        ];

        # Everything inside of these brackets are Zed options
        userSettings = {
          assistant.enabled = false;
          copilot = false;
          edit_prediction = false;
          node = {
            path = lib.getExe pkgs.nodejs;
            npm_path = lib.getExe' pkgs.nodejs "npm";
          };
          lsp = {
            rust-analyzer = {
              binary = {
                path = lib.getExe pkgs.rust-analyzer;
                path_lookup = true;
              };
            };
            nix = {
              binary = {
                path_lookup = true;
              };
            };
          };

          hour_format = "hour24";
          auto_update = false;

          terminal = {
            alternate_scroll = "off";
            blinking = "off";
            copy_on_select = false;
            dock = "bottom";
            detect_venv = {
              on = {
                directories = [
                  ".env"
                  "env"
                  ".venv"
                  "venv"
                ];
                activate_script = "default";
              };
            };
            env = {
              TERM = "alacritty";
            };
            font_family = "FiraCode Nerd Font";
            font_features = null;
            font_size = null;
            line_height = "comfortable";
            option_as_meta = false;
            button = false;
            shell = "system";
            toolbar = {
              title = true;
            };
            working_directory = "current_project_directory";
          };

          vim_mode = false;

          # Tell Zed to use direnv and direnv can use a flake.nix environment
          load_direnv = "shell_hook";
          base_keymap = "VSCode";

          theme = {
            mode = "system";
            light = "One Light";
            dark = "One Dark";
          };

          show_whitespaces = "all";
          ui_font_size = 16;
          buffer_font_size = 16;

        };
      };
    };
}
