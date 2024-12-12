{pkgs, ...}: {
  home.packages = with pkgs; [
    phpactor
  ];
  programs.nixvim.plugins = {
    lsp-format.enable = true;
    lsp = {
      enable = true;
      servers = {
        bashls.enable = true;
        nixd = {
          enable = true;
          autostart = true;
        };
        html.enable = true;
        volar = {
          enable = true;
          autostart = true;
          tslsIntegration = true;
        };
        phpactor = {
          enable = true;
          filetypes = [
            "php"
            "blade.php"
          ];
        };
        ltex = {
          enable = true;
          autostart = true;
        };
        texlab = {
          enable = true;
          autostart = true;
        };
        tinymist.enable = true;
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
