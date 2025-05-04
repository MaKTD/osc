return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "j-hui/fidget.nvim",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
        javascript = { "eslint_d"  },
        typescript = { "eslint_d"  },
        --lua = { "stylua" },
        -- Conform will run multiple formatters sequentially
        --python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        --rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        --javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
    })

    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    require("fidget").setup({})
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { "lua_ls", "ts_ls", "gopls", "denols" },
      handlers = {
        function(server_name)
          require('lspconfig')[server_name].setup({
            capabilities = capabilities
          })
        end,

        zls = function()
          local lspconfig = require("lspconfig")
          lspconfig.zls.setup({
            root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
            settings = {
              zls = {
                enable_inlay_hints = true,
                enable_snippets = true,
                warn_style = true,
              },
            },
          })
          vim.g.zig_fmt_parse_errors = 0
          vim.g.zig_fmt_autosave = 0
        end,
      },

      ['ts_ls'] = function()
        local lspconfig = require("lspconfig")
        lspconfig.ts_ls.setup({
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        })
      end,

      ['denols'] = function()
        local lspconfig = require("lspconfig")
        lspconfig.denols.setup({
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        })
      end,

      ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup {
          capabilities = capabilities,
          settings = {
            Lua = {
              format = {
                enable = true,
                -- Put format options here
                -- NOTE: the value should be STRING!!
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                }
              },
            }
          }
        }
      end,
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      mapping = {
        ['<C-space>'] = {
          i = cmp.mapping.confirm({ select = true }),
        },
        ['<C-y>'] = {
          i = cmp.mapping.complete(),
        },
        ['<C-e>'] = {
          i = cmp.mapping.abort(),
        },
        ['<C-j>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-k>'] = {
          i = function()
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
      },
      --mapping = cmp.mapping.preset.insert({
      --  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
      --  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
      --  ['<C-space>'] = cmp.mapping.confirm({ select = true }),
      --  ['<C-y>'] = cmp.mapping.complete(),
      --}),
      --mapping = cmp.mapping.preset.insert({
      --  ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      --  ['<C-f>'] = cmp.mapping.scroll_docs(4),
      --  ['<C-Space>'] = cmp.mapping.complete(),
      --  ['<C-e>'] = cmp.mapping.abort(),
      --  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      --}),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = {
        ['<Tab>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<S-Tab>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-j>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-k>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-space>'] = {
          c = cmp.mapping.confirm({ select = true }),
        },
        ['<C-y>'] = {
          c = cmp.mapping.confirm({ select = false }),
        },
        ['<C-e>'] = {
          c = cmp.mapping.abort(),
        },
      },
      --mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' }
      }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = {
        ['<Tab>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<S-Tab>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-j>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_next_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-k>'] = {
          c = function()
            local cmp = require('cmp')
            if cmp.visible() then
              cmp.select_prev_item(cmp_select)
            else
              cmp.complete()
            end
          end,
        },
        ['<C-space>'] = {
          c = cmp.mapping.confirm({ select = true }),
        },
        ['<C-y>'] = {
          c = cmp.mapping.confirm({ select = false }),
        },
        ['<C-e>'] = {
          c = cmp.mapping.abort(),
        },
      },
      --mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      }),
      matching = { disallow_symbol_nonprefix_matching = false }
    })

    vim.diagnostic.config({
      --update_in_insert = true,
      virtual_text = true,
      secerity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        --source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
