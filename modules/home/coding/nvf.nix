{ ... }:

{
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        lsp = {
          enable = true;
        };

        languages = {
          nix = {
            enable = true;
            lsp.enable = true;
            format.enable = true;
            extraDiagnostics.enable = true;
            treesitter.enable = true;
          };
          ts.enable = true;
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

        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            enable_cursor_hijack = true;
            enable_git_status = true;
            git_status_async = true;
            enable_opened_markers = true;
            enable_refresh_on_write = true;
          };
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
