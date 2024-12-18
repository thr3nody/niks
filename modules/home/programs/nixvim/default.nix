{inputs, ...}: {
  imports = [
    inputs.nixvim.homeManagerModules.default

    ./options.nix
    ./keymaps.nix

    ./plugins/lsp.nix
    ./plugins/tree.nix
    ./plugins/telescope.nix
    ./plugins/ui.nix
    ./plugins/utils.nix
    ./plugins/cmp.nix
    ./plugins/dap.nix
    # ./plugins/vimtex.nix
    ./plugins/typst-vim.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    extraConfigLua = ''
      require'lspconfig'.volar.setup{
        init_options = {
          -- typescript = {
          --   tsdk = '/home/erine/.bun/install/global/node_modules/typescript/lib'
          -- }
          filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
        }
      }
      require'lspconfig'.nixd.setup{
        offset_encoding = "utf-8"
      }
    '';
  };
}
