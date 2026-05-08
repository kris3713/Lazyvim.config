--- @diagnostic disable: missing-fields, type-not-found, annotation-usage-error
---@module 'lazy'

return --[[@type (LazyPluginSpec[])]]{
  -- Plugins with configs go here
  {
    'ThePrimeagen/refactoring.nvim',---@module 'refactoring'
    ---@type refactor.UserConfig
    opts = {},
    dependencies = {
      { 'lewis6991/async.nvim', lazy = true }
    },
    event = { 'BufReadPre', 'BufNewFile' },
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local refactoring = require('refactoring')
      local modes = { 'n', 'x' }

      keys = {
        {
          '<leader>r',
          '',
          desc = '+refactor',
          mode = modes
        },
        {
          '<leader>rs',
          function()
            refactoring.select_refactor {}
          end,
          desc = 'Select Refactor',
          mode = modes
        },
        {
          '<leader>re',
          '',
          desc = '+inline operations',
          mode = modes
        },
        {
          '<leader>rev',
          function()
            return refactoring.inline_var {}
          end,
          desc = 'Inline Variable',
          mode = modes,
          expr = true
        },
        {
          '<leader>ref',
          function()
            return refactoring.inline_func {}
          end,
          desc = 'Inline Function',
          mode = modes,
          expr = true
        },
        {
          '<leader>rx',
          '',
          desc = '+extraction operations',
          mode = modes,
          expr = true
        },
        {
          '<leader>rxv',
          function()
            return refactoring.extract_var {}
          end,
          desc = 'Extract Variable',
          mode = modes,
          expr = true
        },
        {
          '<leader>rxf',
          function()
            return refactoring.extract_func {}
          end,
          desc = 'Extract Function',
          mode = modes,
          expr = true
        },
        {
          '<leader>rxF',
          function()
            return refactoring.extract_func_to_file {}
          end,
          desc = 'Extract Function To File',
          mode = modes,
          expr = true
        }
      }

      return keys
    end
  },
  {
    'jake-stewart/multicursor.nvim',---@module 'multicursor-nvim'
    ---@type mc.MultiCursorOpts
    opts = {},
    branch = '1.0',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function (_, keys)
      -- Customize how cursors look.
      local set_hl = vim.api.nvim_set_hl
      local reverse = { reverse = true }
      local visual = { link = 'Visual' }
      local sign_column = { link = 'SignColumn'}
      set_hl(0, 'MultiCursorCursor', reverse)
      set_hl(0, 'MultiCursorVisual', visual)
      set_hl(0, 'MultiCursorSign', sign_column)
      set_hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      set_hl(0, 'MultiCursorDisabledCursor', reverse)
      set_hl(0, 'MultiCursorDisabledVisual', visual)
      set_hl(0, 'MultiCursorDisabledSign', sign_column)

      local mc = require('multicursor-nvim')
      local modes = { 'n', 'x' }

      keys = {
        {
          '<leader>m',
          '',
          desc = '+multicursor',
          mode = modes
        },
        {
          '<leader>m<up>',
          function ()
            mc.lineAddCursor(-1)
          end,
          desc = 'Add a cursor above the main cursor, skipping empty lines',
          mode = modes,
          expr = true
        },
        {
          '<leader>m<down>',
          function()
            mc.lineAddCursor(1)
          end,
          desc = 'Add a cursor below the main cursor, skipping empty lines',
          mode = modes,
          expr = true
        },
        {
          '<leader>m<left>',
          function()
            mc.lineSkipCursor(-1)
          end,
          desc = 'Move only the main cursor up a line, skipping empty lines',
          mode = modes,
          expr = true
        },
        {
          '<leader>m<right>',
          function()
            mc.lineSkipCursor(1)
          end,
          desc = 'Move only the main cursor down a line, skipping empty lines',
          mode = modes,
          expr = true
        },
        {
          '<leader>mn',
          function()
            mc.matchAddCursor(1)
          end,
          desc = 'Add a new cursor by matching the current word/selection. Backwards',
          mode = modes,
          expr = true
        },
        {
          '<leader>ms',
          function()
            mc.matchSkipCursor(1)
          end,
          desc = 'Move only the main cursor by matching the current word/selection. Backwards',
          mode = modes,
          expr = true
        },
        {
          '<leader>mN',
          function()
            mc.matchAddCursor(-1)
          end,
          desc = 'Add a new cursor by matching the current word/selection. Forwards',
          mode = modes,
          expr = true
        },
        {
          '<leader>mS',
          function()
            mc.matchSkipCursor(-1)
          end,
          desc = 'Move only the main cursor by matching the current word/selection. Forwards',
          mode = modes,
          expr = true
        },
        -- {
        --   '<leader>m<c-leftmouse>',
        --   mc.handleMouse,
        --   desc = 'add/remove cursors with mouse click',
        --   mode = 'n',
        --   expr = true
        -- },
        -- {
        --   '<leader>m<c-leftdrag>',
        --   mc.handleMouseDrag,
        --   desc = 'add/remove cursors with (vertical) mouse drag',
        --   mode = 'n',
        --   expr = true
        -- },
        -- {
        --   '<leader>m<c-leftrelease>',
        --   mc.handleMouseRelease,
        --   desc = 'Improve mouse support when dragging with a modifier',
        --   mode = 'n',
        --   expr = true
        -- },
        {
          '<leader>mq',
          mc.toggleCursor,
          desc = 'Disable and enable cursors',
          mode = modes,
          expr = true
        }
      }

      return keys
    end
  },
  {
    'nvim-mini/mini.comment',
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
        end
      }
    },
    version = '*'
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',---@module 'ts_context_commentstring'
    ---@type ts_context_commentstring.Config
    opts = {
      enable_autocmd = false
    }
  },
  {
    'chrisgrieser/nvim-recorder',---@module 'recorder'
    ---@param opts configObj
    opts = function(_, opts)
      if not opts.mapping then
        return
      end

      opts.mapping.switchSlot = '<A-q>'
    end
    -- dependencies = 'rcarriga/nvim-notify'
  },
  {
    'yousefhadder/markdown-plus.nvim',
    ft = 'markdown',
    opts = {}
  },
  -- {
  --   'calops/hmts.nvim',
  --   version = '*'
  -- },
  {
    'nanotee/zoxide.vim',
    init = function() vim.g.zoxide_use_select = 1 end
  },
  {
    'Mgenuit/nvim-dap-kotlin',
    opts = {}
  },
  {
    'leoluz/nvim-dap-go',
    opts = {}
  },
  {
    'mfussenegger/nvim-dap-python',
    keys = {
      {
        '<leader>dPt',
        function() require('dap-python').test_method() end,
        desc = 'Debug Method',
        ft = 'python'
      },
      {
        '<leader>dPc',
        function() require('dap-python').test_class() end,
        desc = 'Debug Class',
        ft = 'python'
      }
    },
    config = function()
      require('dap-python').setup('debugpy-adapter', {})
    end
  },
  {
    'fei6409/log-highlight.nvim',
    opts = {}
  },
  {
    'AckslD/muren.nvim',
    opts = {}
  },
  {
    'nvzone/volt',
    lazy = true
  },
  {
    'kevinhwang91/nvim-hlslens',
    opts = {}
  },
  {
    'nvzone/showkeys',
    cmd = 'ShowkeysToggle',
    opts = { position = 'bottom-center' }
  },
  {
    'nvzone/minty',
    cmd = { 'Shades', 'Heufy' },
    opts = {}
  },
  {
    'abccsss/nvim-gitstatus',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'sontungexpt/better-diagnostic-virtual-text',
    event = 'LspAttach',
    opts = {
      inline = false,
      ui = { above = true }
    }
  },
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      padding_right = 3,
      padding_top = 7,
      border_chars = {
        top_left = '╭',
        top_right = '╮',
        bottom_left = '╰',
        bottom_right = '╯',
      },
      show_borders = true
    }
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false -- last release is way too old
  },
  {
    'cbochs/portal.nvim',
    opts = {}
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = { snippetDir = os.getenv('HOME') .. '/MEGA' }
  },
  {
    'm-demare/hlargs.nvim',
    opts = { color = '#ed8796' }
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {}
  },
  {
    'stevearc/stickybuf.nvim',
    opts = {}
  },
  {
    'ckolkey/ts-node-action',
    opts = {}
  },
  {
    'aaronik/treewalker.nvim',
    opts = {}
  },
  {
    'julienvincent/hunk.nvim',
    cmd = 'DiffEditor',
    opts = {}
  },
  {
    'chentoast/marks.nvim',
    opts = function(_, opts)
      if not opts then
        return
      end

      opts.mappings = {
        set = 'mm',
        delete = 'md',
        delete_line = 'md-',
        delete_bookmark = 'md=',
        delete_buf = 'md<space>'
        -- set_next = "m,",
        -- next = "m]",
        -- preview = "m:",
        -- set_bookmark0 = "m0",
        -- prev = false
      }

      for i = 0, 9 do
        opts.mappings['set_bookmark' .. i] = 'm' .. tostring(i)
        opts.mappings['delete_bookmark' .. i] = 'md' .. tostring(i)
      end
    end,
    event = 'VeryLazy',
    keys = {
      {
        'm',
        '',
        desc = '+marks',
        mode = 'n'
      }
    }
  },
  {
    'sustech-data/wildfire.nvim',
    event = 'VeryLazy',
    opts = {}
  },
  {
    'dstein64/nvim-scrollview',
    opts = {
      excluded_filetypes = { 'NvimTree' }
    }
  },
  {
    'vuki656/package-info.nvim',
    opts = {
      package_manager = 'bun'
    }
  },
  {
    'L3MON4D3/cmp-luasnip-choice',
    opts = {
      auto_open = true -- Automatically open nvim-cmp on choice node (default: true)
    }
  },
  {
    'mvllow/modes.nvim',
    version = '*',
    opts = {}
  },
  {
    'https://git.sr.ht/~havi/telescope-toggleterm.nvim',
    event = 'TermOpen',
    dependencies = 'nvim-lua/popup.nvim',
    opts = {}
  },
  {
    'jmbuhr/otter.nvim',
    opts = {}
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}
  },
  {
    'DaikyXendo/nvim-material-icon',
    opts = {
      color_icons = true,
      default = true
    }
  },
  {
    'xzbdmw/colorful-menu.nvim',---@module 'colorful-menu'
    ---@type ColorfulMenuConfig
    opts = {
      max_width = 60
    }
  },
  {
    'seblyng/roslyn.nvim',---@module 'roslyn'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = 'roslyn'
    },
    ft = { 'cs' }
  },
  {
    'nacro90/numb.nvim',
    opts = {}
  },
  {
    'luckasRanarison/tailwind-tools.nvim',---@module 'tailwind-tools'
    ---@type TailwindTools.Option
    opts = {
      server = {
        settings = {
          experimental = {
            classRegex = {
              {
                "classnames\\(([^)]*)\\)",
                "'([^']*)'"
              },
              {
                "classList={{([^;]*)}}",
                "\\s*?[\"'`]([^\"'`]*).*?:"
              },
              {
                "classNames:\\s*{([\\s\\S]*?)}",
                "\\s?[\\w].*:\\s*?[\"'`]([^\"'`]*).*?,?\\s?"
              },
              "class:\\s*['\\\"]([^'\\\"]*)['\\\"]",
              ":class=\\s*\\{([^}]+)\\}",
              "(?:enter|leave)(?:From|To)?=\\s*(?:\"|'|{`)([^(?:\"|'|`})]*)",
              "tw`([^`]*)`",
              "tw=\"([^\"]*)", -- <div tw="..." />
              "tw={\"([^\"}]*)", -- <div tw={"..."} />
              "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
              "tw\\(.*?\\)`([^`]*)" -- tw(Component)`...`
            }
          },
          includeLanguages = {
            elixir = 'html-eex',
            eelixir = 'html-eex',
            heex = 'html-eex'
          }
        }
      }
    },
    name = 'tailwind-tools',
    build = function() vim.cmd('UpdateRemotePlugins') end
  },
  {
    'Wansmer/treesj',
    opts = {
      ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
      use_default_keymaps = false
    }
  },
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      filetype_exclude = {
        'netrw',
        'tutor',
        'snacks_dashboard',
        'snacks_terminal'
      }
    }
  },
  {
    'tzachar/highlight-undo.nvim',
    opts = {
      ignored_filetypes = {
        'neo-tree',
        'fugitive',
        'TelescopePrompt',
        'mason',
        'lazy',
        'netrw',
        'tutor',
        'snacks_dashboard',
        'snacks_terminal'
      }
    }
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    event = 'ModeChanged *:[vV\22]',
    opts = {
      list_chars = {
        tab = '|󰌒'
      }
    }
  },
  {
    'nvimdev/lspsaga.nvim',---@module 'lspsaga'
    ---@type LspsagaConfig
    opts = {
      ui = { code_action = '' },
      symbol_in_winbar = { enable = false }
    }
  },
  {
    'mikavilpas/yazi.nvim',---@module 'yazi'
    ---@type YaziConfig
    opts = {
      open_for_directories = true
    },
    event = 'VeryLazy'
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    opts = {}
  },
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      handler_opts = { border = 'rounded' },
      hint_prefix = '❔ ',
      floating_window_off_y = -2
    },
    event = 'InsertEnter',
  },
  {
    'Bekaboo/dropbar.nvim',---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = {
          border = 'rounded'
        }
      }
    },
    lazy = false
  },
  {
    'gbprod/phpactor.nvim',
    ft = 'php',
    opts = {
      install = {
        path = vim.fn.stdpath('data') .. '/mason/bin',
        bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor'
      }
    }
  },
  {
    'windwp/nvim-ts-autotag',---@module 'nvim-ts-autotag'
    ---@type nvim-ts-autotag.PluginSetup
    opts = {
      --- @diagnostic disable-next-line: param-type-mismatch
      -- Has potential for a complex configuration
      opts = {
        enable_close = true,
        enable_close_on_slash = true,
        enable_rename = true
      }
    }
  },
  {
    'zbirenbaum/neodim',---@module 'neodim'
    ---@type neodim.Options
    opts = {
      hide = {
        underline = false,
        virtual_text = false,
        signs = false
      }
    },
    event = 'LspAttach'
  },
  {
    'chrisgrieser/nvim-origami',---@module 'origami'
    ---@type Origami.config
    opts = {
      autoFold = { enabled = false },
      foldKeymaps = { setup = false }
    },
    event = 'VeryLazy'
  },
  {
    'michaelb/sniprun',
    opts = {},
    branch = 'master',
    build = 'sh ./install.sh'
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
  },
  {
    'GCBallesteros/jupytext.nvim',
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'md',
          style = 'markdown',
          force_ft = 'markdown' -- you can set whatever filetype you want here
        }
      }
    }
  },
  {
    'linux-cultist/venv-selector.nvim',---@module 'venv-selector'
    ---@type venv-selector.Settings
    opts = {
      options = {
        notify_user_on_venv_activation = true
      }
    },
    ft = 'python',
    cmd = 'VenvSelect',
    --  Call config for Python files and load the cached venv automatically
    keys = {
      {
        '<leader>cv',
        function() vim.cmd('VenvSelect') end,
        desc = 'Select VirtualEnv',
        ft = 'python'
      }
    }
  },
  {
    'cappyzawa/trim.nvim',
    opts = {
      -- harper:ignore
      -- if you want to ignore markdown file.
      -- you can specify filetypes.
      ft_blocklist = {
        'snacks_dashboard',
        'snacks_terminal'
      },
      -- harper:ignore
      -- if you want to disable trim on write by default
      trim_on_write = false,
      -- highlight trailing spaces
      highlight = true
    }
  },
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true
        },
        -- required for Windows users
        use_absolute_path = vim.fn.has('win32') and true or false
      }
    },
    event = 'VeryLazy'
  },
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy'
  },
  {
    'LunarVim/bigfile.nvim',
    config = function()
      --- @diagnostic disable-next-line: param-type-mismatch
      require('bigfile').setup {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          'indent_blankline',
          'illuminate',
          'lsp',
          'treesitter',
          ---@diagnostic disable-next-line: assign-type-mismatch
          'syntax',
          'matchparen',
          'vimopts',
          'filetype'
        }
      }
    end
  },
  {
    'nvim-tree/nvim-tree.lua',---@module 'nvim-tree'
    ---@param opts nvim_tree.config?
    opts = function(_, opts)
      ---@param rel_path string
      ---@return string
      local function label(rel_path)
        rel_path = rel_path:gsub(
          tostring(os.getenv('HOME')),
          '~',
          1
        )
        -- local a = path:gsub('([a-zA-Z])[a-z0-9]+', '%1')
        -- local b = tostring(path:match '[a-zA-Z]([a-z0-9]*)$' or '')
        return rel_path
      end

      local setEnable = { enable = true }

      if not opts then
        return
      end
      -- Has potential for a more complex configuration
      opts.sync_root_with_cwd = true
      opts.respect_buf_cwd = true
      opts.update_focused_file = {
        enable = true,
        update_root = setEnable
      }
      opts.filters = setEnable
      opts.renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = '󰄱',
              staged = '󰱒'
            }
          }
        },
        root_folder_label = label,
        group_empty = label
      }
    end,
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    deactivate = function() vim.cmd('NvimTreeClose') end
  },
  {
    'rmagatti/auto-session',---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true
      },
      lazy_support = true,
      lsp_stop_on_restore = true,
      suppressed_dirs = { os.getenv('HOME'), '/' },
      continue_restore_on_error = false,
      cwd_change_handling = true,
      pre_restore_cmds = {
        function()
          ---@param name string
          ---@return integer
          local function create_augroup(name)
            return vim.api.nvim_create_augroup(name, { clear = true })
          end

          local create_autocmd = vim.api.nvim_create_autocmd

          -- Enforce Unix-style line endings for all files
          create_autocmd({ 'BufEnter', 'BufRead', 'WinEnter' }, {
            group = create_augroup('change_line_ending'),
            desc = 'Ensure that all files have Unix-style line endings',
            pattern = '*',
            callback = function()
              local bufnr = vim.api.nvim_get_current_buf()
              local is_true = (vim.bo[bufnr].filetype ~= 'help') or
                (vim.bo[bufnr].filetype ~= 'man') or
                (vim.bo[bufnr].filetype ~= 'gitcommit')

              if is_true and vim.bo[bufnr].modifiable then
                vim.o.fileformats = 'unix,dos,mac'
              end
            end
          })
        end
      }
    },
    lazy = false
  },
  {
    'milanglacier/minuet-ai.nvim',
    opts = {
      cmp = {
        enable_auto_complete = false
      },
      blink = {
        enable_auto_complete = false
      },
      lsp = {
        completion = {
          enable = true
        }
      },
      provider = 'openai_fim_compatible',
      n_completions = 1,
      context_window = 512,
      provider_options = {
        openai_fim_compatible = {
          api_key = 'TERM',
          name = 'llama-swap',
          end_point = 'http://localhost:1234/v1/completions',
          model = 'granite-4.1',
          -- optional = {
          --   max_tokens = 56
          -- },
          -- Llama.cpp does not support the `suffix` option in FIM completion.
          -- Therefore, we must disable it and manually populate the special
          -- tokens required for FIM completion.
          template = {
            ---@param context_before_cursor string
            ---@param context_after_cursor string
            ---@return string
            prompt = function(context_before_cursor, context_after_cursor, _)
              return '<|fim_prefix|>'
                .. context_before_cursor
                .. '<|fim_suffix|>'
                .. context_after_cursor
                .. '<|fim_middle|>'
            end,
            suffix = false
          }
        }
      }
    },
    enabled = true
  }
}
