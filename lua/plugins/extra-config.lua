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
    ---@module 'mason'
    ---@param opts MasonSettings
    opts = function(_, opts)
      opts.registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry'
      }


      -- Ensure none of these are installed by mason.
      -- https://github.com/LazyVim/LazyVim/discussions/6493#discussioncomment-14469953
      --- @diagnostic disable-next-line: inject-field
      opts.ensure_installed = vim.tbl_filter(function(p)
        return not vim.tbl_contains(
          {
            'stylua',
            'shellcheck',
            'shfmt',
            'markdown-toc',
            'markdownlint-cli2'
          },
        p)
        --- @diagnostic disable-next-line: undefined-field
      end, opts.ensure_installed)
    end
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
    dependencies = {
      'Issafalcon/neotest-dotnet',
      'fredrikaverpil/neotest-golang',
      'nvim-neotest/neotest-python'
    },
    ---@param opts neotest.Config
    opts = function(_, opts)
      opts.adapters = vim.tbl_deep_extend('force', opts.adapters or {}, --[[@as neotest.Adapter[] ]]{
        ['neotest-dotnet'] = {},
        ['neotest-golang'] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true -- requires leoluz/nvim-dap-go
        },
        -- Here you can specify the settings for the adapter, i.e.
        -- runner = 'pytest',
        -- python = '.venv/bin/python'
        ['neotest-python'] = {}
      })
    end
  },
  {
    'akinsho/bufferline.nvim',
    ---@type bufferline.Config
    opts = {
      options = {
        always_show_bufferline = true,
        separator_style = 'thick',
        hover = {
          enabled = true,
          delay = 120,
          reveal = { 'close' }
        }
      }
    }
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
    ---@param opts TelescopeConfig
    opts = function(_, opts)
      opts.extensions = vim.tbl_deep_extend('force', opts.extensions or {}, {
        ast_grep = {
          command = {
            'ast-grep', -- For Linux, use `ast-grep` instead of `sg`
            '--json=stream'
          }, -- must have --json=stream
          grep_open_files = false, -- search in opened files
          lang = nil -- string value, specify language for ast-grep `nil` for default
        }
      })
    end
  },
  {
    'folke/snacks.nvim',
    ---@type snacks.Config
    opts = {
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
    },
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

      cmp.setup {
        window = {
          completion = {
            border = 'rounded'
          },
          documentation = {
            border = 'rounded'
          }
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = function(entry, vim_item)
            local lspkind__cmp_format = require('lspkind').cmp_format { mode = 'symbol_text' }
            local extra_opts = lspkind__cmp_format(entry, vim.deepcopy(vim_item))
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
        -- sources = cmp_config.sources,
        -- mapping = cmp.mapping.preset.insert {
        --   ['<a-y>'] = require('minuet').make_cmp_map()
        -- },
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
            ---@type cmp_go_deep.Options
            option = {}
          }
        }
      })
    end,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      opts.sources = opts.sources or {}

      ---@type cmp.SourceConfig[]
      local cmp_sources = {
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'dap' },
        { name = 'render-markdown' },
        { name = 'diag-codes' },
        { name = 'luasnip_choice' },
        { name = 'npm' },
        { name = 'pypi' },
        { name = 'git' }
      }

      for _, source in ipairs(cmp_sources) do
        table.insert(opts.sources, source)
      end
    end
  },
  {
    'mfussenegger/nvim-dap',
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
    dependencies = {
      'gbprod/none-ls-shellcheck.nvim'
    },
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
      -- ---@module 'null-ls.builtins._meta.hover'
      -- local null_ls__hover = null_ls.builtins.hover

      -- none-ls extra sources

      local null_ls__formatting__ruff = require('none-ls.formatting.ruff')
      local null_ls__diagnostics__ruff = require('none-ls.diagnostics.ruff')
      -- local null_ls__formatting__tex_fmt = require('none-ls.formatting.tex_fmt')

      -- local null_ls__sources = null_ls.get_sources()

      local new_null_ls_sources = {
        -- null_ls__code_actions.gitsigns,
        null_ls__code_actions.refactoring,
        null_ls__code_actions.statix,
        null_ls__code_actions.gomodifytags,
        null_ls__code_actions.impl,
        null_ls__completion.luasnip,
        null_ls__completion.tags,
        null_ls__diagnostics.deadnix,
        null_ls__diagnostics.dotenv_linter,
        null_ls__diagnostics.editorconfig_checker.with {
          filetypes = { 'editorconfig' }
        },
        null_ls__diagnostics.fish,
        null_ls__diagnostics.hadolint,
        null_ls__diagnostics.ktlint,
        null_ls__diagnostics.markdownlint,
        null_ls__diagnostics.markdownlint_cli2,
        null_ls__diagnostics.rpmspec,
        null_ls__diagnostics__ruff,
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
        null_ls__formatting.goimports,
        null_ls__formatting.markdownlint,
        null_ls__formatting.shfmt.with {
          extra_filetypes = { 'bash' }
        },
        null_ls__formatting__ruff,
        -- null_ls__formatting__tex_fmt,
        null_ls__formatting.uncrustify,
        null_ls__formatting.yamlfmt
      }

      opts.sources = opts.sources or {}

      -- for _, source in ipairs(new_null_ls_sources) do
      --   table.insert(null_ls__sources, source)
      -- end

      --- NOTE: Don't use vim.tbl_deep_extend with this one
      opts.sources = vim.list_extend(opts.sources, new_null_ls_sources)

      -- null_ls.setup {
      --   sources = null_ls__sources
      -- }
    end
  },
  {
    'nvim-mini/mini.icons',
    opts = {
      file = {
        ['.go-version'] = { glyph = '', hl = 'MiniIconsBlue' }
      },
      filetype = {
        gotmpl = { glyph = '󰟓', hl = 'MiniIconsGrey' }
      }
    }
  }
}
