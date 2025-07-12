{
  programs.nixvim.plugins = {
    neo-tree = {
      enable = false; # Try Snacks.explorer
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      window.mappings = {
        "<space>" = {
          command = "toggle_node";
          # disable `nowait` if you have existing combos starting with this char that you want to use
          nowait = false;
        };
        "<2-LeftMouse>" = "open";
        "<cr>" = "open";
        "<esc>" = "revert_preview";
        P = {
          command = "toggle_preview";
          config = {use_float = true;};
        };
        l = "open";
        S = "open_split";
        # S = "split_with_window_picker";
        s = "open_vsplit";
        # s = "vsplit_with_window_picker";
        t = "open_tabnew";
        # "<cr>" = "open_drop";
        # t = "open_tab_drop";
        w = "open_with_window_picker";
        C = "close_node";
        h = "close_node";
        "." = "toggle_hidden";
        # H = "set_root";
        z = "close_all_nodes";
        # Z = "expand_all_nodes";
        R = "refresh";
        a = {
          command = "add";
          # some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = "none"; # "none", "relative", "absolute"
          };
        };
        A = "add_directory";
        d = "delete";
        r = "rename";
        y = "copy_to_clipboard";
        x = "cut_to_clipboard";
        p = "paste_from_clipboard";
        c = "copy";
        m = "move";
        e = "toggle_auto_expand_width";
        q = "close_window";
        "?" = "show_help";
        "<" = "prev_source";
        ">" = "next_source";
      };
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
          "<C-b>" = "actions.parent";
          "<C-q>" = "actions.close";
          "<C-h>" = "actions.select_split";
          "<C-r>" = "actions.refresh";
          "<C-Space>" = "actions.preview";
          "<C-s>" = "actions.select_vsplit";
          "<C-t>" = "actions.select_tab";
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
