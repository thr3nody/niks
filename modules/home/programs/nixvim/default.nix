{inputs, ...}: {
  imports = [
    inputs.nixvim.homeModules.default

    ./options.nix
    ./keymaps.nix

    ./plugins/lsp.nix
    ./plugins/tree.nix
    # ./plugins/telescope.nix # Use Snacks.picker now
    ./plugins/ui.nix
    ./plugins/utils.nix
    ./plugins/cmp.nix
    ./plugins/dap.nix
    ./plugins/typst-vim.nix
    ./plugins/presence.nix
    ./plugins/lazygit.nix
    ./plugins/render-markdown.nix
    ./plugins/snacks.nix
  ];

  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox = {
      enable = true;
      settings.transparent_mode = true;
    };
    extraConfigLua = ''
      local util = require("lspconfig.util")
      require'lspconfig'.volar.setup{
      --   init_options = {
      --     -- typescript = {
      --     --   tsdk = '/home/erine/.bun/install/global/node_modules/typescript/lib'
      --     -- }
      --     filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'}
      --   }
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }
      require'lspconfig'.ts_ls.setup{
        init_options = {
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = "/home/erine/.bun/install/global/node_modules/@vue/typescript-plugin",
              languages = {"javascript", "typescript", "vue"},
            },
          },
        },
        filetypes = {
          "javascript",
          "typescript",
          "vue",
        },
      }
      require'lspconfig'.nixd.setup{
        offset_encoding = "utf-8"
      }
      require'lspconfig'.omnisharp.setup {
        cmd = {
          "OmniSharp",
          "--languageserver",
          "--hostPID", tostring(vim.fn.getpid()),
        },
        on_attach = function(client)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      }
      require('render-markdown').setup({ latex = { enabled = false } })
      require'lspconfig'.djlsp.setup {
        root_dir = function(fname)
          return util.root_pattern("manage.py")(fname)
        end,
      }
    '';
  };
}
