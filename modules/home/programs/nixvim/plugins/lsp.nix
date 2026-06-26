{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    phpactor
  ];
  programs.nixvim.plugins = {
    lsp-format.enable = false;
    lsp = {
      enable = true;
      servers = {
        bashls = {
          enable = true;
          package = pkgs.bash-language-server;
        };
        gdscript = {
          enable = true;
          package = null;
        };
        omnisharp = {
          enable = true;
          package = pkgs.omnisharp-roslyn;
          extraOptions = {
            cmd = [
              "OmniSharp"
              "--languageserver"
              "--hostPID"
              "\${tostring(vim.fn.getpid())}"
            ];
          };
        };
        nixd = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
          autostart = true;
          extraOptions = {
            offset_encoding = "utf-8";
          };
        };
        html = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
          autostart = true;
          filetypes = ["html" "templ" "htmldjango"];
          rootMarkers = ["package.json" ".git" "devenv.nix"];
          extraOptions = {
            init_options = {
              provideFormatter = false;
            };
          };
        };
        volar = {
          enable = true;
          package = pkgs.vue-language-server;
          tslsIntegration = true;
        };
        ts_ls = {
          enable = true;
          package = pkgs.typescript-language-server;
          filetypes = ["javascript" "typescript" "vue"];
          extraOptions = {
            init_options = {
              plugins = lib.mkForce [
                {
                  name = "@vue/typescript-plugin";
                  location = "/home/erine/.bun/install/global/node_modules/@vue/typescript-plugin";
                  languages = ["javascript" "typescript" "vue"];
                }
              ];
            };
          };
        };
        cssls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
          filetypes = ["css" "scss"];
        };
        phpactor = {
          enable = true;
          package = pkgs.phpactor;
          filetypes = [
            "php"
            "blade.php"
          ];
        };
        tinymist = {
          enable = true;
          package = pkgs.tinymist;
          settings.exportPdf = "onType";
        };
        pyright = {
          enable = true;
          package = pkgs.pyright;
        };
        djlsp = {
          enable = true;
          package = null;
          extraOptions = {
            root_dir = ''
              function(fname)
                local util = require("lspconfig.util")
                return util.root_pattern("manage.py")(fname)
              end
            '';
          };
        };
        dockerls = {
          enable = true;
          package = pkgs.dockerfile-language-server;
        };
        jsonls = {
          enable = true;
          package = pkgs.vscode-langservers-extracted;
        };
        tailwindcss = {
          enable = true;
          package = pkgs.tailwindcss-language-server;
        };
        ccls = {
          enable = true;
          package = pkgs.ccls;
        };
      };
    };
    none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          statix = {
            enable = true;
            package = pkgs.statix;
          };
        };
        formatting = {
          black = {
            enable = true;
            package = pkgs.python3.pkgs.black;
          };
          alejandra = {
            enable = true;
            package = pkgs.alejandra;
          };
          prettier = {
            enable = true;
            package = pkgs.prettier;
            disableTsServerFormatter = true;
          };
          clang_format = {
            enable = true;
            package = pkgs.clang-tools;
          };
          djlint = {
            enable = true;
            package = pkgs.djlint;
            settings.extra_args = [
              "--indent"
              "2"
            ];
          };
          typstyle = {
            enable = true;
            package = pkgs.typstyle;
            settings.extra_args = [
              "--line-width"
              "80"
              "--wrap-text"
            ];
          };
        };
      };
    };
  };
}
