{
  programs.nixvim = {
    autoGroups = {
      FormatOnSave = {
        clear = true;
      };
      TinymistPin = {
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
      {
        event = "FileType";
        pattern = ["typst" "markdown"];
        command = "setlocal spell";
      }
      {
        event = "LspAttach";
        group = "TinymistPin";
        desc = "Pin the nearest main.typ as tinymist's main file.";
        callback.__raw = ''
          function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client or client.name ~= "tinymist" then
              return
            end

            local main = vim.fs.find("main.typ", {
              upward = true,
              path = vim.fs.dirname(vim.api.nvim_buf_get_name(args.buf)),
            })[1]

            if main then
              client:exec_cmd({
                title = "pin",
                command = "tinymist.pinMain",
                arguments = { main },
              }, { bufnr = args.buf })
            end
          end
        '';
      }
    ];
  };
}
