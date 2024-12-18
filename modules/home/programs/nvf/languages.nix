_: {
  programs.nvf.settings.vim = {
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
  };
}
