{
  programs.nixvim = {
    autoGroups = {
      FormatOnSave = {
        clear = true;
      };
    };
    autoCmd = [
      {
        event = "BufWritePre";
        group = "FormatOnSave";
        pattern = "*";
        desc = "Format with null-ls only.";
        callback.__raw = ''
          function()
            local clients = vim.lsp.get_active_clients({ bufnr = 0 })
            for _, client in ipairs(clients) do
              if client.name == "null-ls" or client.name == "none-ls" then
                vim.lsp.buf.format({ async = false, name = client.name })
                return
              end
            end
          end
        '';
      }
      {
        event = "FileType";
        pattern = ["c" "cpp"];
        callback.__raw = ''
          function()
            vim.opt_local.expandtab = false
            vim.opt_local.tabstop = 8
            vim.opt_local.shiftwidth = 8
            vim.opt_local.softtabstop = 8
          end
        '';
      }
    ];
  };
}
