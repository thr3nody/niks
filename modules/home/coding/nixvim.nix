{ ... }:

{
  programs.nixvim = {
    enable = true;

    colorschemes.gruvbox.enable = true;

    plugins = {
      lualine.enable = true;
      lsp = {
        tsserver.enable = true;
        lua-ls = {
          enable = true;
          settings.telemetry.enable = false;
        };
        rust-analyzer = {
          enable = true;
          installCargo = true;
        };
      };
    };

    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
    };
  };
}
