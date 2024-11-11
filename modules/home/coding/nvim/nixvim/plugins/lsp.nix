{
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        nixd.enable = true;
        html.enable = true;
        volar = {
          enable = true;
          autostart = true;
          tslsIntegration = true;
        };
      };
    };
    none-ls = {
      enable = true;
      sources = {
        diagnostics = {
          statix.enable = true;
        };
        formatting = {
          alejandra.enable = true;
          prettier = {
            enable = true;
          };
        };
      };
    };
  };
}
