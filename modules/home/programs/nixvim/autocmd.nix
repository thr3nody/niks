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
    ];
  };
}
