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
          lua-language-server
          taplo
        ];
        extensions = [
          "nix"
          "toml"
          "rust"
          "make"
          "lua"
          "discord-presence"
        ];

        userSettings = {
          disable_ai = true;

          node = {
            path = lib.getExe pkgs.nodejs;
            npm_path = lib.getExe' pkgs.nodejs "npm";
          };

          # ---------- LSP ----------
          lsp = {
            rust-analyzer = {
              binary = {
                path = lib.getExe pkgs.rust-analyzer;
                path_lookup = true;
              };
              initialization_options = {
                check.command = "clippy";
                cargo = {
                  allFeatures = true;
                };
                procMacro.enable = true;
                rust.analyzerTargetDir = true; # keep IDE analysis out of your normal `target/`
                inlayHints = {
                  closureReturnTypeHints.enable = "always";
                  lifetimeElisionHints = {
                    enable = "skip_trivial";
                    useParameterNames = true;
                  };
                };
              };
            };

            nix = {
              binary = {
                path_lookup = true;
              };
              settings = {
                formatting.command = [ "nixfmt" ];
              };
            };

            lua-language-server = {
              settings = {
                Lua = {
                  diagnostics.enable = true;
                  workspace.checkThirdParty = false;
                  telemetry.enable = false;
                };
              };
            };

            taplo = {
              settings = {
                # taplo mostly reads a .taplo.toml in-project; this just makes sure
                # schema-based completion/validation stays on
                schema.enabled = true;
              };
            };

            discord_presence = {
              initialization_options = {
                application_id = "1263505205522337886";
                base_icons_url = "https://raw.githubusercontent.com/xhyrom/zed-discord-presence/main/assets/icons/";
                state = "Working on {filename}:{line_number}";
                details = "Editing in {workspace}";
                git_integration = true;
                languages = {
                  nix = {
                    state = "makin cheese in {filename}";
                    details = "makinsomthing";
                    large_image = "{base_icons_url}/nix.png";
                    large_text = "Nix";
                  };
                  rust = {
                    state = "corrupting {filename}";
                    details = "abandon all hope, ye who see this";
                    large_image = "{base_icons_url}/rust.png";
                    large_text = "Rust-ing something";
                  };
                };
              };
            };
          };

          # ---------- per-language formatting/editing ----------
          languages = {
            Rust = {
              formatter = "language_server";
              format_on_save = "on";
              tab_size = 4;
            };
            Nix = {
              formatter = "language_server";
              format_on_save = "on";
              tab_size = 2;
            };
            TOML = {
              formatter = "language_server";
              format_on_save = "on";
              tab_size = 2;
            };
            Lua = {
              formatter = "language_server";
              format_on_save = "on";
              tab_size = 2;
            };
          };

          # ---------- inlay hints ----------
          inlay_hints = {
            enabled = true;
            show_type_hints = true;
            show_parameter_hints = true;
            show_other_hints = true;
          };

          # ---------- general editor behavior ----------
          format_on_save = "on";
          remove_trailing_whitespace_on_save = true;
          ensure_final_newline_on_save = true;
          tab_size = 2;
          soft_wrap = "editor_width";
          cursor_blink = false;
          relative_line_numbers = false;
          scroll_beyond_last_line = "one_page";

          scrollbar = {
            show = "auto";
            git_diff = true;
            search_results = true;
          };

          minimap = {
            show = "auto";
            max_width_columns = 80;
          };

          gutter = {
            line_numbers = true;
            folds = true;
          };

          # ---------- git ----------
          git = {
            inline_blame = {
              enabled = true;
              delay_ms = 600;
            };
            hunk_style = "staged_hollow";
          };

          # ---------- UI chrome ----------
          tab_bar = {
            show = true;
            show_nav_history_buttons = true;
          };

          status_bar = {
            active_language_button = true;
            cursor_position_button = true;
          };

          project_panel = {
            dock = "right";
            git_status = true;
            indent_size = 20;
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
