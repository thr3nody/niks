{
  programs.nixvim.plugins = {
    luasnip.enable = true;
    cmp-buffer.enable = true;
    cmp-emoji.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-dap.enable = true;
    cmp_luasnip.enable = true;

    cmp = {
      enable = true;
      settings = {
        snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        sources = [
          {name = "nvim_lsp";}
          {name = "luasnip";}
          {
            name = "buffer";
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          {name = "nvim_lua";}
          {name = "mkdnflow";}
          {name = "path";}
        ];
        window = {
          completion = {
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,Search:PmenuSel";
            scrollbar = false;
            sidePadding = 0;
            border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
          };

          documentation = {
            border = ["╭" "─" "╮" "│" "╯" "─" "╰" "│"];
            winhighlight = "FloatBorder:CmpBorder,Normal:CmpPmenu,Search:PmenuSel";
          };
        };
        mapping = {
          "<Tab>" = "cmp.mapping.select_next_item()";
          "<S-Tab>" = "cmp.mapping.select_prev_item()";
          "<Down>" = "cmp.mapping.select_next_item()";
          "<Up>" = "cmp.mapping.select_prev_item()";
          "<C-j>" = "cmp.mapping.select_next_item()";
          "<C-k>" = "cmp.mapping.select_prev_item()";
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";
        };
        formatting = {
          fields = ["abbr" "kind" "menu"];
          format = ''
            function(entry, item)
              local icons = {
                Namespace = "󰌗",
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰆧",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈚",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰊄",
                Table = "",
                Object = "󰅩",
                Tag = "",
                Array = "[]",
                Boolean = "",
                Number = "",
                Null = "󰟢",
                String = "󰉿",
                Calendar = "",
                Watch = "󰥔",
                Package = "",
                Copilot = "",
                Codeium = "",
                TabNine = "",
              }

              local icon = icons[item.kind] or ""
              item.kind = string.format("%s %s", icon, item.kind or "")

              local menu_icon = {
                nvim_lsp = "NLSP",
                nvim_lua = "NLUA",
                luasnip  = "LSNP",
                buffer   = "BUFF",
                path     = "PATH",
              }

              item.menu = menu_icon[entry.source.name]

              -- fixed_width = 60
              fixed_width = fixed_width or false

              local content = item.abbr

              if fixed_width then
                vim.o.pumwidth = fixed_width
              end

              local win_width = vim.api.nvim_win_get_width(0)
              local max_content_width =
                fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

              if #content > max_content_width then
                item.abbr =
                  vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
              else
                item.abbr =
                  content .. string.rep(" ", max_content_width - #content)
              end

              return item
            end
          '';
        };
      };
    };
  };
}
