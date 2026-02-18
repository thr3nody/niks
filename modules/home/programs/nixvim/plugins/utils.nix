{
  programs.nixvim.plugins = {
    muren.enable = true;
    flash.enable = true;
    tmux-navigator.enable = true;
    comment.enable = true;
    nvim-autopairs.enable = true;
    ts-autotag = {
      enable = true;
      settings = {
        opts = {
          enable_close = true;
          enable_close_on_slash = true;
          enable_rename = true;
        };
        aliases = {
          php = "html";
          blade = "html";
          "blade.php" = "html";
          vue = "html";
        };
      };
    };
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
  };
}
