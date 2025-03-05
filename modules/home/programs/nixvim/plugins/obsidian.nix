{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
      picker.name = "telescope.nvim";
      new_notes_location = "current_dir";
      workspaces = [
        {
          name = "Work";
          path = "~/Documents/Obsidian/Work";
        }
        {
          name = "Study";
          path = "~/Documents/Obsidian/Study";
        }
      ];
    };
  };
}
