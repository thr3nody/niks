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
        bashls.enable = true;
        gdscript = {
          enable = true;
          package = null;
        };
        omnisharp = {
          enable = true;
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
          autostart = true;
          extraOptions = {
            offset_encoding = "utf-8";
          };
        };
        html = {
          enable = true;
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
          tslsIntegration = true;
        };
        ts_ls = {
          enable = true;
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
          filetypes = ["css" "scss"];
        };
        phpactor = {
          enable = true;
          filetypes = [
            "php"
            "blade.php"
          ];
        };
        tinymist.enable = true;
        pyright = {
          enable = true;
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
        dockerls.enable = true;
        jsonls.enable = true;
        tailwindcss.enable = true;
        postgres_lsp.enable = true;
      };
    };
    none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          statix.enable = true;
        };
        formatting = {
          black.enable = true;
          alejandra.enable = true;
          prettier = {
            disableTsServerFormatter = true;
            enable = true;
          };
          clang_format.enable = true;
          djlint = {
            enable = true;
            settings.extra_args = [
              "--indent"
              "2"
            ];
          };
        };
      };
    };
  };
}
