{
  programs.nixvim.plugins.typst-vim = {
    enable = true;
    settings.pdf_viewer = "zathura";
    keymaps.watch = "<leader>wa";
  };
}
