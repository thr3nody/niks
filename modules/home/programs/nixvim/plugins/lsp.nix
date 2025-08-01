{pkgs, ...}: {
  home.packages = with pkgs; [
    phpactor
  ];
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    conform-nvim = {
      enable = true;
      settings = {formatters_by_ft.python = ["black"];};
    };
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        gdscript = {
          enable = true;
          package = null;
        };
        omnisharp.enable = true;
        nixd = {
          enable = true;
          autostart = true;
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
        };
        phpactor = {
          enable = true;
          filetypes = [
            "php"
            "blade.php"
          ];
        };
        tinymist = {
          enable = true;
          autostart = true;
        };
        pyright = {
          enable = true;
        };
        djlsp = {
          enable = true;
          package = null;
        };
        dockerls.enable = true;
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
          prettierd = {
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
