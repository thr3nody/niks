{
  programs.nixvim = {
    keymaps = [
      {
        key = "<leader>E";
        action = "<cmd>Oil --float<cr>";
        options.desc = "Oil";
      }
      {
        key = "-";
        action = "<cmd>Oil<cr>";
        options.desc = "Oil";
      }
      {
        key = "<leader>e";
        action = "<cmd>Neotree toggle right<cr>";
        options.desc = "Neotree";
      }

      {
        key = "<C-h>";
        action = "<cmd>TmuxNavigateLeft<cr>";
      }
      {
        key = "<C-j>";
        action = "<cmd>TmuxNavigateDown<cr>";
      }
      {
        key = "<C-k>";
        action = "<cmd>TmuxNavigateUp<cr>";
      }
      {
        key = "<C-l>";
        action = "<cmd>TmuxNavigateRight<cr>";
      }

      {
        key = "s";
        action = "<cmd>lua require('flash').jump()<cr>";
        options.desc = "Flash";
      }
      {
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<cr>";
        options.desc = "LSP Hover";
      }

      {
        key = "<leader> ";
        action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
        options.desc = "Telescope";
      }
      {
        key = "<leader>sg";
        action = "<cmd>lua require('telescope.builtin').live_grep()<cr>";
        options.desc = "Livegrep";
      }
      {
        key = "<leader>sf";
        action = "<cmd>lua require('telescope.builtin').find_files()<cr>";
        options.desc = "Find Files";
      }
      {
        key = "<leader>sb";
        action = "<cmd>lua require('telescope.builtin').buffers()<cr>";
        options.desc = "Buffers";
      }
      {
        key = "<leader>sh";
        action = "<cmd>lua require('telescope.builtin').help_tags()<cr>";
        options.desc = "Help Tags";
      }
      {
        key = "<leader>sc";
        action = "<cmd>lua require('telescope.builtin').commands()<cr>";
        options.desc = "Commands";
      }
      {
        key = "<leader>sm";
        action = "<cmd>lua require('telescope.builtin').marks()<cr>";
        options.desc = "Marks";
      }
      {
        key = "<leader>so";
        action = "<cmd>lua require('telescope.builtin').oldfiles()<cr>";
        options.desc = "Oldfiles";
      }
      {
        key = "<leader>ss";
        action = "<cmd>lua require('telescope.builtin').spell_suggest()<cr>";
        options.desc = "Spell Suggest";
      }
      {
        key = "<leader>sr";
        action = "<cmd>:noh<return><esc>";
        options.desc = "Reset search";
      }
      {
        key = "<leader>st";
        action = "<cmd>TodoTelescope<cr>";
        options.desc = "Todos";
      }
    ];
  };
}
