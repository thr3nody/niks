{
  programs.nixvim.plugins = {
    muren.enable = true;
    tailwind-tools.enable = true;
    treesj = {
      enable = true;
      settings.use_default_keymaps = true;
    };
    flash.enable = true;
    image.enable = true;
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
    wrapping = {
      enable = true;
      settings = {
        auto_set_mode_filetype_allowlist = [
          "markdown"
          "text"
          "latex"
          "typst"
        ];
        create_commands = true;
        create_keymaps = true;
        notify_on_switch = true;
        set_nvim_opt_default = true;
      };
    };
    harpoon = {
      enable = true;
      enableTelescope = true;
      # keymapsSilent = true;
      # keymaps = {
      #   addFile = "<leader>ha";
      #   toggleQuickMenu = "<leader>hu";
      #   navNext = "<leader>hl";
      #   navPrev = "<leader>hh";
      #   navFile = {
      #     "1" = "<leader>h1";
      #     "2" = "<leader>h2";
      #     "3" = "<leader>h3";
      #     "4" = "<leader>h4";
      #   };
      # };
    };
  };
}
