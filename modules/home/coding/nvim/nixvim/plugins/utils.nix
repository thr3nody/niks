{
  programs.nixvim.plugins = {
    flash.enable = true;
    image = {
      enable = true;
      integrations.markdown = {
        clearInInsertMode = true;
        onlyRenderImageAtCursor = true;
      };
    };
    comment.enable = true;
    nvim-autopairs.enable = true;
    ts-autotag.enable = true;
    friendly-snippets.enable = true;
    todo-comments.enable = true;
    twilight.enable = true;
    treesitter = {
      enable = true;
      nixGrammars = true;
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
    };
    harpoon = {
      enable = true;
      enableTelescope = true;
      keymapsSilent = true;
      keymaps = {
        addFile = "<leader>ha";
        toggleQuickMenu = "<leader>hu";
        navNext = "<leader>hl";
        navPrev = "<leader>hh";
        navFile = {
          "1" = "<leader>h1";
          "2" = "<leader>h2";
          "3" = "<leader>h3";
          "4" = "<leader>h4";
        };
      };
    };
  };
}
