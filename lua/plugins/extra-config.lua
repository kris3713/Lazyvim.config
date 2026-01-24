--- @diagnostic disable: param-type-mismatch, missing-fields, assign-type-mismatch, need-check-nil, missing-parameter

return --[[@type (LazyPluginSpec[])]]{
  --harper:ignore
  -- Configuration for plugins already installed by LazyExtras or by LazyVim (by default)
  -- {
  --   'LazyVim/LazyVim',
  --   -- url = 'https://github.com/comfysage/LazyVim.git',
  --   branch = 'fix/catppuccin/bufferline-api-change',
  --   version = false
  -- },
  {
    'L3MON4D3/LuaSnip',
    init = function()
      require('luasnip.loaders.from_vscode').lazy_load {
        paths = { os.getenv('HOME') .. '/MEGA' }
      }
    end
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    cmd = 'LazyDev',
    dependencies = {
      {
        'DrKJeff16/wezterm-types',
        lazy = true,
        version = false
      }
    },
    ---@module 'lazydev'
    ---@param opts lazydev.Config
    opts = function(_, opts)
      ---@type lazydev.Library.spec[]
      local extra = {
        { path = 'wezterm-types', mods = { 'wezterm' } }
      }

      opts.library = vim.tbl_deep_extend('force', opts.library or {}, extra)
    end
  },
  {
    'mason-org/mason.nvim',---@module 'mason'
    ---@param opts MasonSettings | { ensure_installed: table }
    opts = function(_, opts)
      opts.registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry',
        'github:MKindberg/ghostty-ls'
      }

      -- Ensure none of these are installed by mason.
      -- https://github.com/LazyVim/LazyVim/discussions/6493#discussioncomment-14469953
      --- @diagnostic disable-next-line: inject-field
      opts.ensure_installed = vim.tbl_filter(
        ---@param old_table table
        function(old_table)
          return not vim.tbl_contains({
            'stylua',
            'shellcheck',
            'shfmt',
            'markdown-toc',
            'markdownlint-cli2'
          }, old_table)
        end,
      opts.ensure_installed or {})
    end
  },
  {
    'folke/which-key.nvim',---@module 'which-key'
    ---@param opts wk.Opts
    opts = function(_, opts)
      ---@type wk.Spec[]
      local extra_keys = {
        { '<leader>bq', desc = 'Sort by' },
        (function()
          local bufnr = vim.api.nvim_get_current_buf()
          local wk_mapping = {}

          if vim.bo[bufnr].filetype == 'man' then
            ---@cast wk_mapping wk.Spec[]
            wk_mapping = { 'gO', desc = 'Open table of contents' }
          else
            ---@cast wk_mapping wk.Spec[]
            wk_mapping = { 'gO', desc = 'Open document symbols' }
          end

          return wk_mapping
        end)()
      }

      opts.spec = vim.list_extend(opts.spec or {}, extra_keys)
    end
  },
  {
    'folke/noice.nvim',---@module 'noice'
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
      'nvim-neotest/neotest-python',
      'olimorris/neotest-rspec'
    },
    ---@module 'neotest'
    ---@param opts neotest.Config
    opts = function(_, opts)
      ---@type neotest.Adapter[]
      local new_adapters = {
        ['neotest-dotnet'] = {},
        ['neotest-golang'] = {
          -- Here we can set options for neotest-golang, e.g.
          -- go_test_args = { "-v", "-race", "-count=1", "-timeout=60s" },
          dap_go_enabled = true -- requires leoluz/nvim-dap-go
        },
        -- Here you can specify the settings for the adapter, i.e.
        -- runner = 'pytest',
        -- python = '.venv/bin/python'
        ['neotest-python'] = {},
        ['neotest-rspec'] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          -- rspec_cmd = function()
          --   return vim.tbl_flatten({
          --     "bundle",
          --     "exec",
          --     "rspec",
          --   })
          -- end
        }
      }

      opts.adapters = vim.tbl_deep_extend('force', opts.adapters or {}, new_adapters)
    end
  },
  {
    'akinsho/bufferline.nvim',---@module 'bufferline'
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
        'ast_grep',
        'package_info',
        'toggleterm'
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
    'folke/snacks.nvim',---@module 'snacks'
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
        lualine_b = {
          {
            function()
              local recording_register = vim.fn.reg_recording()

              if recording_register == '' then
                return ''
              else
                return 'Recording @' .. recording_register
              end
            end,
            color = { fg = '#ff9e64' }
          },
          'branch',
          'gitstatus'
        },
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
          {
            'encoding',
            show_bomb = true
          },
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
                require('utils').switch_indent_style(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh {}
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
                require('utils').set_indent_size(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh {}
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

                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh {}
              end
            end
          },
          {
            'filetype',
            ---@param clicks integer
            on_click = function(clicks, _, _)
              if clicks == 2 then
                require('telescope.builtin').filetypes {}
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
            ---@module 'cmp_go_deep'
            ---@type cmp_go_deep.Options
            option = {}
          }
        }
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          {
              name = 'buffer',
              option = { keyword_pattern = [[\k\+]] }
          },
          { name = 'buffer-lines' }
        }
      })
    end,---@module 'cmp'
    ---@param opts cmp.Setup|cmp.ConfigSchema
    opts = function(_, opts)
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
        { name = 'git' },
        { name = 'buffer-lines' }
      }

      opts.sources = vim.list_extend(opts.sources or {}, cmp_sources)
    end
  },
  {
    'mfussenegger/nvim-dap',
    --TODO: Replace this with function(_, opts)
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
    ---@param opts { sources: table }
    opts = function(_, opts)
      local null_ls = require('null-ls')

      ---@module 'null-ls.builtins._meta.code_actions'
      local code_actions = null_ls.builtins.code_actions
      ---@module 'null-ls.builtins._meta.completion'
      local completion = null_ls.builtins.completion
      ---@module 'null-ls.builtins._meta.diagnostics'
      local diagnostics = null_ls.builtins.diagnostics
      ---@module 'null-ls.builtins._meta.formatting'
      local formatting = null_ls.builtins.formatting
      -- ---@module 'null-ls.builtins._meta.hover'
      -- local hover = null_ls.builtins.hover

      -- none-ls extensions
      local exts = {
        code_actions = {
          shellcheck = require('none-ls-shellcheck.code_actions')
        },

        formatting = {
          golangci_lint = require('none-ls.formatting.golangci_lint'),
          jq = require('none-ls.formatting.jq'),
          ruff = require('none-ls.formatting.ruff'),
          tex_fmt = require('none-ls.formatting.tex_fmt'),
          yq = require('none-ls.formatting.yq')
        },

        diagnostics = {
          ruff = require('none-ls.diagnostics.ruff'),
          shellcheck = require('none-ls-shellcheck.diagnostics')
        }
      }

      local new_sources = {
        code_actions.gitsigns,
        code_actions.refactoring,
        code_actions.gomodifytags,
        code_actions.impl,
        exts.code_actions.shellcheck,
        code_actions.statix,
        code_actions.ts_node_action.with {
          -- Don't remove, this is needed by `nvim-tree.lua`
          disabled_filetypes = {
            'conf',
            'dosini',
            'fish',
            'spec',
            'systemd',
            'toml',
            'sh',
            'bash',
            'text',
            'nix',
            'lisp',
            ''
          }
        },
        diagnostics.deadnix,
        diagnostics.dotenv_linter,
        diagnostics.editorconfig_checker.with {
          filetypes = { 'editorconfig' }
        },
        diagnostics.erb_lint,
        diagnostics.fish,
        diagnostics.hadolint,
        diagnostics.golangci_lint,
        diagnostics.ktlint,
        diagnostics.markdownlint,
        diagnostics.markdownlint_cli2,
        diagnostics.pydoclint,
        diagnostics.rpmspec,
        diagnostics.rubocop,
        exts.diagnostics.ruff,
        diagnostics.todo_comments,
        diagnostics.trail_space,
        exts.diagnostics.shellcheck,
        diagnostics.statix,
        diagnostics.stylelint,
        diagnostics.yamllint,
        formatting.alejandra,
        formatting.biome.with {
          extra_filetypes = { 'astro' }
        },
        formatting.erb_lint,
        formatting.fish_indent,
        formatting.gofumpt,
        formatting.goimports,
        exts.formatting.golangci_lint,
        exts.formatting.jq,
        formatting.markdownlint,
        formatting.shfmt.with {
          extra_filetypes = { 'bash' }
        },
        exts.formatting.ruff,
        formatting.uncrustify,
        exts.formatting.yq
      }

      --- NOTE: Don't use vim.tbl_deep_extend with this one
      opts.sources = vim.list_extend(opts.sources or {}, new_sources)
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
