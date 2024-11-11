{
  programs.nixvim.plugins = {
    neo-tree = {
      enable = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
    };
    oil = {
      enable = true;
      settings = {
        default_file_explorer = true;
        skip_confirm_for_simple_edits = true;
        win_options = {
          concealcursor = "ncv";
          conceallevel = 3;
          cursorcolumn = false;
          foldcolumn = "0";
          list = false;
          signcolumn = "no";
          spell = false;
          wrap = false;
        };
        float = {padding = 5;};
        keymaps = {
          "h" = "actions.parent";
          "q" = "actions.close";
          "<C-h>" = "actions.select_split";
          "r" = "actions.refresh";
          "p" = "actions.preview";
          "<C-s>" = "actions.select_vsplit";
          "t" = "actions.select_tab";
          "<CR>" = "actions.select";
          _ = "actions.open_cwd";
          "`" = "actions.cd";
          "g." = "actions.toggle_hidden";
          "g?" = "actions.show_help";
          "g\\" = "actions.toggle_trash";
          gs = "actions.change_sort";
          gx = "actions.open_external";
          "~" = "actions.tcd";
        };
      };
    };
  };
}
