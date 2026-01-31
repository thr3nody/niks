{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      completion = {
        min_chars = 2;
        nvim_cmp = true;
      };
      new_notes_location = "current_dir";
      preferred_link_style = "wiki";
      workspaces = [
        {
          name = "Personal";
          path = "~/Documents/Obsidian";
        }
      ];
      attachments = {
        folder = "./Images";
      };
      templates = {
        folder = "/Templates";
        dateFormat = "%Y-%m-%d";
        timeFormat = "%H:%M";
        substitutions = {};
      };
      legacy_commands = false;
      note_id_func = {
        __raw = ''
          function(title)
            if not title or title == "" then
              return tostring(os.time())
            end
            return title
          end
        '';
      };
    };
  };
}
