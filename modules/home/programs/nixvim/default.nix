{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.default

    ./options.nix
    ./keymaps.nix
    ./autocmd.nix

    ./plugins/lsp.nix
    ./plugins/tree.nix
    ./plugins/ui.nix
    ./plugins/utils.nix
    ./plugins/cmp.nix
    ./plugins/dap.nix
    ./plugins/typst-vim.nix
    ./plugins/presence.nix
    ./plugins/lazygit.nix
    ./plugins/render-markdown.nix
    ./plugins/snacks.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox = {
      enable = true;
      settings.transparent_mode = true;
    };
  };
}
