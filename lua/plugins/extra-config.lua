--- @diagnostic disable: param-type-mismatch, missing-fields, assign-type-mismatch, need-check-nil, missing-parameter

return {
  -- Configuration for plugins already installed by LazyExtras or by LazyVim (by default)
  -- {
  --   'LazyVim/LazyVim',
  --   -- url = 'https://github.com/comfysage/LazyVim.git',
  --   branch = 'fix/catppuccin/bufferline-api-change',
  --   version = false
  -- },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown' },
    opts = {
      file_types = { 'markdown' }
    }
  },
  {
    'L3MON4D3/LuaSnip',
    init = function()
      require('luasnip.loaders.from_vscode').lazy_load {
        paths = { os.getenv('HOME') .. '/MEGA' }
      }
    end
  },
  {
    'mason-org/mason.nvim',
    ---@module 'mason',
    ---@type MasonSettings
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry'
      }
    }
  },
  {
    'folke/noice.nvim',
    ---@module 'noice'
    ---@type NoiceConfig
    opts = {
      lsp = {
        hover = { silent = true },
        message = { silent = true },
        signature = {
          auto_open = { enabled = false }
        }
      }
    }
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'Issafalcon/neotest-dotnet'
    },
    opts = function(_, opts)
      opts = vim.tbl_deep_extend('force', opts or {}, {
         -- Here we can set options for neotest-dotnet
        ['neotest-dotnet'] = {}
      })
    end
  },
  {
    'akinsho/bufferline.nvim',
    ---@module 'bufferline'
    ---@param opts bufferline.Config
    opts = function(_, opts)
      opts = vim.tbl_deep_extend('force', opts or {}, {
        options = {
          always_show_bufferline = true,
          separator_style = 'thick',
          hover = {
            enabled = true,
            delay = 120,
            reveal = { 'close' }
          }
        }
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    -- telescope extensions
    init = function()
      local telescope = require('telescope')

      local telescope_plugins = {
        'ui-select',
        'undo',
        'frecency',
        'dap',
        'telescope-tabs',
        'ast_grep'
      }

      -- load telescope plugins
      for _, plugin in ipairs(telescope_plugins) do
        telescope.load_extension(plugin)
      end
    end,
    ---@module 'annotations.telescope'
    ---@param opts TelescopeConfig
    opts = function(_, opts)
      opts = vim.tbl_deep_extend('force', opts or {}, --[[@as TelescopeConfig]]{
        extensions = {
          ast_grep = {
            command = {
              'ast-grep', -- For Linux, use `ast-grep` instead of `sg`
              '--json=stream'
            }, -- must have --json=stream
            grep_open_files = false, -- search in opened files
            lang = nil -- string value, specify language for ast-grep `nil` for default
          }
        }
      })
    end
  },
  {
    'folke/snacks.nvim',
    ---@module 'snacks'
    ---@param opts snacks.Config
    opts = function(_, opts)
      opts = vim.tbl_deep_extend('force', opts or {}, --[[@as snacks.Config]]{
        explorer = {
          enabled = false
        },
        picker = {
          previewers = {
            diff = {
              builtin = false,
              cmd = { 'delta' }
            },
            git = {
              builtin = false
            },
            man_pager = 'nvim +Man!'
          }
        },
        win = {
          border = 'rounded'
        },
        notifier = {
          style = 'fancy'
        }
      })
    end,
    keys = {
      { '<leader>S', false }, -- Disables Scratchpad keymap
      { '<C-/>', false, mode = 'i' } -- Disables Snacks terminal keymap
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_b = { 'branch', 'gitstatus' },
        lualine_c = {
          {
            'diagnostics',
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                ---@diagnostic disable-next-line: missing-fields
                require('trouble').toggle {
                  mode = 'diagnostics',
                  filter = { buf = bufnr }
                }
              end
            end
          }
        },
        lualine_x = {
          { 'encoding', show_bomb = true },
          {
            -- indent_style
            function()
              local bufnr = vim.api.nvim_get_current_buf()
              local indent_style = require('guess-indent').guess_from_buffer(bufnr)

              if indent_style ~= 'tabs' then
                return 'Indent Style: Spaces'
              else
                return 'Indent Style: Tabs'
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                require('functions.switch_indent_style').switch_indent_style(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh()
              end
            end
          },
          {
            -- indent_size
            function()
              local bufnr = vim.api.nvim_get_current_buf()
              local indent_style = require('guess-indent').guess_from_buffer(bufnr)

              if indent_style ~= 'tabs' then
                return 'Indent Size: ' .. vim.bo[bufnr].shiftwidth
              else
                return 'Indent Size: ' .. vim.bo[bufnr].tabstop
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                require('functions.set_indent_size_prompt').set_indent_size(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh()
              end
            end
          },
          {
            -- fileformat
            function()
              local bufnr = vim.api.nvim_get_current_buf()

              if vim.bo[bufnr].fileformat == 'unix' then
                return 'LF (unix)'
              elseif vim.bo[bufnr].fileformat == 'dos' then
                return 'CRLF (dos)'
              elseif vim.bo[bufnr].fileformat == 'mac' then
                return 'CR (mac)'
              else
                return vim.bo[bufnr].fileformat
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                if vim.bo[bufnr].fileformat == 'unix' then
                  vim.bo[bufnr].fileformat = 'dos'
                elseif vim.bo[bufnr].fileformat == 'dos' then
                  vim.bo[bufnr].fileformat = 'mac'
                elseif vim.bo[bufnr].fileformat == 'mac' then
                  vim.bo[bufnr].fileformat = 'unix'
                end
                require('lualine').refresh()
              end
            end
          },
          {
            'filetype',
            ---@param clicks integer
            on_click = function(clicks, _, _)
              if clicks == 2 then
                require('telescope.builtin').filetypes()
              end
            end
          }
        },
        lualine_y = { 'searchcount', 'selectioncount', 'progress' },
        lualine_z = { 'location' }
      }
    }
  },
  {
    'hrsh7th/nvim-cmp',
    init = function()
      local cmp = require('cmp')
      local cmp_config = cmp.get_config()

      ---@type cmp.SourceConfig[]
      local cmp_sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'dap' },
        { name = 'render-markdown' },
        { name = 'diag-codes' },
        { name = 'luasnip_choice' },
        { name = 'npm' },
        { name = 'pypi' }
      }

      for _, source in ipairs(cmp_sources) do
        table.insert(cmp_config.sources, source)
      end

      cmp.setup {
        window = {
          completion = {
            border = 'rounded'
          },
          ---@diagnostic disable-next-line: missing-fields
          documentation = {
            border = 'rounded'
          }
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, vim_item)
            local lspkind = require('lspkind').cmp_format { mode = 'symbol_text' }
            local extra_opts = lspkind(entry, vim.deepcopy(vim_item))
            local highlights_info = require('colorful-menu').cmp_highlights(entry)

            -- highlight_info is nil means we are missing the ts parser, it's
            -- better to fallback to use default `vim_item.abbr`. What this plugin
            -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
            if highlights_info ~= nil then
              vim_item.abbr_hl_group = highlights_info.highlights
              vim_item.abbr = highlights_info.text
            end

            local strings = vim.split(extra_opts.kind, '%s', { trimempty = true })
            vim_item.kind = ' ' .. (strings[1] or '') .. ' '
            vim_item.menu = ''

            return vim_item
          end
        },
        sources = cmp_config.sources,
        -- mapping = cmp.mapping.preset.insert {
        --   ['<a-y>'] = require('minuet').make_cmp_map()
        -- },
        ---@diagnostic disable-next-line: missing-fields
        performance = {
          fetching_timeout = 2000
        }
      }

      -- only for sql
      cmp.setup.filetype('sql', {
        sources = {
          { name = 'sql' }
        }
      })

      -- only for golang
      cmp.setup.filetype('go', {
        sources = {
          { name = 'go_pkgs' },
          {
            name = 'go_deep',
            keyword_length = 3,
            max_item_count = 5,
            ---@module 'cmp_go_deep'
            ---@type cmp_go_deep.Options
            option = {}
          }
        }
      })
    end
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      local dap = require('dap')

      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
          type = 'executable',
          command = vim.fn.exepath('netcoredbg'),
          args = { '--interpreter=vscode' },
          options = {
            detached = false
          }
        }
      end

      for _, lang in ipairs { 'cs', 'fsharp', 'vb' } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = 'netcoredbg',
              name = 'Launch file',
              request = 'launch',
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}'
            }
          }
        end
      end
    end
  },
  {
    'nvimtools/none-ls.nvim',
    ---@param opts table
    opts = function(_, opts)
      local null_ls = require('null-ls')

      ---@module 'null-ls.builtins._meta.code_actions'
      local null_ls__code_actions = null_ls.builtins.code_actions
      ---@module 'null-ls.builtins._meta.completion'
      local null_ls__completion = null_ls.builtins.completion
      ---@module 'null-ls.builtins._meta.diagnostics'
      local null_ls__diagnostics = null_ls.builtins.diagnostics
      ---@module 'null-ls.builtins._meta.formatting'
      local null_ls__formatting = null_ls.builtins.formatting
      ---@module 'null-ls.builtins._meta.hover'
      local null_ls__hover = null_ls.builtins.hover

      -- none-ls extra sources

      local null_ls__formatting__ruff = require('none-ls.formatting.ruff')
      -- local null_ls__formatting__tex_fmt = require('none-ls.formatting.tex_fmt')

      -- local null_ls__sources = null_ls.get_sources()

      local new_null_ls_sources = {
        null_ls__code_actions.gitsigns,
        null_ls__code_actions.refactoring,
        null_ls__code_actions.statix,
        null_ls__completion.luasnip,
        null_ls__completion.tags,
        null_ls__diagnostics.actionlint,
        null_ls__diagnostics.deadnix,
        null_ls__diagnostics.dotenv_linter,
        null_ls__diagnostics.editorconfig_checker.with {
          filetypes = { 'editorconfig' }
        },
        null_ls__diagnostics.fish,
        null_ls__diagnostics.ktlint,
        null_ls__diagnostics.markdownlint,
        null_ls__diagnostics.markdownlint_cli2,
        null_ls__diagnostics.rpmspec,
        null_ls__diagnostics.todo_comments,
        null_ls__diagnostics.trail_space,
        null_ls__diagnostics.statix,
        -- null_ls__diagnostics.selene,
        null_ls__diagnostics.pydoclint,
        null_ls__diagnostics.yamllint,
        null_ls__formatting.alejandra,
        null_ls__formatting.biome.with {
          extra_filetypes = { 'astro' }
        },
        -- null_ls__formatting.prettier,
        null_ls__formatting.fish_indent,
        null_ls__formatting.gofumpt,
        null_ls__formatting.markdownlint,
        null_ls__formatting.shfmt.with {
          extra_filetypes = { 'bash' }
        },
        null_ls__formatting__ruff,
        -- null_ls__formatting__tex_fmt,
        null_ls__formatting.uncrustify,
        null_ls__formatting.yamlfmt
      }

      -- for _, source in ipairs(new_null_ls_sources) do
      --   table.insert(null_ls__sources, source)
      -- end

      opts.sources = vim.list_extend(opts.sources or {}, new_null_ls_sources)

      -- null_ls.setup {
      --   sources = null_ls__sources
      -- }
    end
  }
}
