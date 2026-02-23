--- @diagnostic disable: missing-fields, type-not-found, annotation-usage-error
---@module 'lazy'

return --[[@type (LazyPluginSpec[])]]{
  -- Plugins with configs go here
  {
    'calops/hmts.nvim',
    version = '*'
  },
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
    -- stylua: ignore
    keys = {
      { '<leader>dPt', function() require('dap-python').test_method() end, desc = 'Debug Method', ft = 'python' },
      { '<leader>dPc', function() require('dap-python').test_class() end, desc = 'Debug Class', ft = 'python' }
    },
    config = function()
      require('dap-python').setup('debugpy-adapter')
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
    'saecki/live-rename.nvim',
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
    event = 'VeryLazy',
    opts = {}
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
      package_manager = 'pnpm'
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
    config = function()
      -- Has potential for a complex configuration
      local otter = require('otter')
      otter.setup()
    end
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
    'xzbdmw/colorful-menu.nvim',
    ---@type ColorfulMenuConfig
    opts = {
      max_width = 80
    }
  },
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs' },
    ---@type RoslynNvimConfig
    opts = {
      filewatching = 'roslyn'
    }
  },
  {
    'nacro90/numb.nvim',
    opts = {}
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',---@module 'ts_context_commentstring'
    ---@type ts_context_commentstring.Config?
    opts = {
      enable_autocmd = false
    }
  },
  {
    'numToStr/Comment.nvim',
    -- Has potential for a complex configuration
    config = function()
      local c = require('ts_context_commentstring.integrations.comment_nvim')
      --- @diagnostic disable-next-line: param-type-mismatch
      require('Comment').setup {
        pre_hook = c.create_pre_hook()
      }
    end
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = function() vim.cmd('UpdateRemotePlugins') end,
    opts = {}
  },
  -- {
  --   'zeioth/garbage-day.nvim',
  --   event = 'VeryLazy',
  --   opts = {
  --     aggressive_mode = true
  --   }
  -- },
  {
    'Wansmer/treesj',
    opts = {}
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
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = 'nvimtools/hydra.nvim',
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    opts = {}
  },
  {
    'nvimdev/lspsaga.nvim',---@module 'lspsaga'
    ---@type LspsagaConfig
    opts = {
      ui = {
        code_action = ''
      },
      symbol_in_winbar = { enable = false }
    }
  },
  {
    'alex-popov-tech/store.nvim',
    cmd = 'Store',
    dependencies = { 'OXY2DEV/markview.nvim' },
    opts = {}
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',---@module 'yazi'
    ---@type YaziConfig
    opts = {
      open_for_directories = true
    }
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    opts = {}
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      handler_opts = {
        border = 'rounded'
      },
      hint_prefix = '❔ '
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    lazy = false,---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = {
          border = 'rounded'
        }
      }
    }
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
    'windwp/nvim-ts-autotag',
    config = function()
      --- @diagnostic disable-next-line: param-type-mismatch
      -- Has potential for a complex configuration
      require('nvim-ts-autotag').setup {
        opts = {
          enable_close = true,
          enable_close_on_slash = true,
          enable_rename = true
        }
      }
    end
  },
  {
    'zbirenbaum/neodim',
    event = 'LspAttach',---@module 'neodim'
    ---@type neodim.Options
    opts = {
      hide = {
        underline = false,
        virtual_text = false,
        signs = false
      }
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',---@module 'ufo'
    ---@type UfoConfig
    opts = {
      provider_selector = function(_, _, _)
        return { 'treesitter', 'indent' }
      end
    }
  },
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh ./install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    opts = {}
  },
  {
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup {
        custom_language_formatting = {
          python = {
            extension = 'md',
            style = 'markdown',
            force_ft = 'markdown' -- you can set whatever filetype you want here
          }
        }
      }
    end
  },
  {
    'linux-cultist/venv-selector.nvim',
    ft = 'python',
    cmd = 'VenvSelect',---@module 'venv-selector'
    ---@type venv-selector.Settings
    opts = {
      options = {
        notify_user_on_venv_activation = true
      }
    },
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
    'hasansujon786/nvim-navbuddy',
    dependencies = {
      {
        'SmiteshP/nvim-navic',
        -- lazy = true,
        init = function() vim.g.navic_silence = true end,
        opts = function()
          Snacks.util.lsp.on({ method = 'textDocument/documentSymbol' }, function(bufnr, client)
            require('nvim-navic').attach(client, bufnr)
          end)

          return {
            separator = " ",
            highlight = true,
            depth_limit = 5,
            icons = {
              File = ' ',
              Module = ' ',
              Namespace = ' ',
              Package = ' ',
              Class = ' ',
              Method = ' ',
              Property = ' ',
              Field = ' ',
              Constructor = ' ',
              Enum = ' ',
              Interface = ' ',
              Function = ' ',
              Variable = ' ',
              Constant = ' ',
              String = ' ',
              Number = ' ',
              Boolean = ' ',
              Array = ' ',
              Object = ' ',
              Key = ' ',
              Null = ' ',
              EnumMember = ' ',
              Struct = ' ',
              Event = ' ',
              Operator = ' ',
              TypeParameter = ' '
            },
            lazy_update_context = true,
            lsp = { auto_attach = true }
          }
        end
      },
      'MunifTanjim/nui.nvim'
    },
    opts = {
      lsp = { auto_attach = true }
    }
  },
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
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
    }
  },
  {
    'kylechui/nvim-surround',
    version = '3.1.8', -- TODO: Migrate to version 4.x.x
    event = 'VeryLazy',
    opts = {
      keymaps = {
        insert = '<Nop>',
        insert_line = '<Nop>',
        normal = 'gss',
        normal_cur = 'gss',
        normal_line = 'gsS',
        normal_cur_line = 'gsSs',
        visual = 'gss',
        visual_line = 'gsS',
        delete = 'gsd',
        change = 'gsc',
        change_line = 'gsC'
      }
    }
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      -- Has potential for a more complex configuration
      require('actions-preview').setup {
        backend = 'telescope',
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            -- height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 25,
            ---@param max_lines integer
            preview_height = function(_, _, max_lines)
              return max_lines - 20
            end
          }
        },
        highlight_command = {
          require('actions-preview.highlight').delta()
        }
      }
    end
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
    'nvim-tree/nvim-tree.lua',
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    config = function()
      ---@param path string
      ---@return string
      local function label(path)
        path = path:gsub(tostring(os.getenv('HOME')), '~', 1)
        -- local a = path:gsub('([a-zA-Z])[a-z0-9]+', '%1')
        -- local b = tostring(path:match '[a-zA-Z]([a-z0-9]*)$' or '')
        return path
      end

      -- Has potential for a more complex configuration
      require('nvim-tree').setup {
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        filters = { enable = false },
        ---@param bufnr integer
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')
          local vim_keymap = vim.keymap

          local function edit_or_open()
            local node = api.tree.get_node_under_cursor()
            --- @diagnostic disable-next-line: undefined-field
            if node and node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file
              api.node.open.edit()
              -- Close the tree if file was opened
              api.tree.close()
            end
          end

          -- harper:ignore

          -- open as vsplit on current node
          local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()
            --- @diagnostic disable-next-line: undefined-field
            if node and node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file as vsplit
              api.node.open.vertical()
            end
            -- Finally refocus on tree if it was lost
            api.tree.focus()
          end

          ---Sets options for keymaps
          ---@param desc string
          ---@param silent boolean?
          ---@return vim.keymap.set.Opts
          local function opts(desc, silent)
            silent = silent or false
            ---@type vim.keymap.set.Opts
            return { desc = 'nvim-tree: ' .. desc, silent = silent, noremap = true, nowait = true }
          end

          -- default mappings (Copied from eddiebergman)
          api.config.mappings.default_on_attach(bufnr)

          -- Set keymaps on attach (Copied from eddiebergman)
          vim_keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
          vim_keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
          vim_keymap.set('n', 'h', api.tree.close, opts('Close'))
          vim_keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))
        end,
        renderer = {
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
      }
    end,
    deactivate = function() vim.cmd('NvimTreeClose') end
  },
  {
    'rmagatti/auto-session',
    lazy = false,---@module 'auto-session'
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
    }
  }
}
