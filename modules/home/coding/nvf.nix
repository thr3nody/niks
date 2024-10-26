{...}: {
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        lsp = {
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          lspconfig.enable = true;
        };

        languages = {
          nix = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
            extraDiagnostics.enable = true;
            treesitter.enable = true;
          };
          ts = {
            enable = true;
            extensions = {
              ts-error-translator.enable = true;
            };
            extraDiagnostics.enable = true;
            format.enable = true;
            lsp.enable = true;
            treesitter = {
              enable = true;
            };
          };
          sql.enable = true;
          html = {
            enable = true;
            treesitter = {
              enable = true;
              autotagHtml = true;
            };
          };
          markdown.enable = true;
          php.enable = true;
        };

        treesitter = {
          enable = true;
          addDefaultGrammars = true;
          context.enable = true;
          highlight.enable = true;
          autotagHtml = true;
        };

        telescope = {
          enable = true;
        };

        autoIndent = true;
        autocomplete.enable = true;
        autopairs.enable = true;

        comments.comment-nvim = {
          enable = true;
        };

        filetree.nvimTree = {
          enable = true;
        };

        dashboard = {
          # alpha.enable = true;
          startify.enable = true;
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
      };
    };
  };
}
