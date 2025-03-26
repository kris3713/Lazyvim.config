return {
  -- No config plugins go here
  'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
  'nvim-tree/nvim-web-devicons',
  'nvimtools/none-ls-extras.nvim',
  'cappyzawa/trim.nvim',
  'Tastyep/structlog.nvim',
  -- Plugins with configs go here
  {
    'aznhe21/actions-preview.nvim',
    config = true
  },
  {
    'numToStr/Comment.nvim',
    config = true
  },
  {
    'nanotee/zoxide.vim',
    init = function()
      vim.g.zoxide_use_select = 1
      -- -- Enable if you want to start zoxide.vim on startup
      -- if vim.fn.argc() == 0 then
      --   vim.defer_fn(function () vim.api.nvim_command('Zi') end, 0)
      -- end
    end
  },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = true
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '/' }
    }
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    opts = {
      space_char = '·'
    }
  },
  {
    'antosha417/nvim-lsp-file-operations',
    config = true
  },
  { -- Copied and modified from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/neo-tree.lua
    'nvim-neo-tree/neo-tree.nvim',
    --- @module 'neo-tree'
    --- @type neotree.Config
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
      open_files_do_not_replace_types = {
        'terminal',
        'Trouble',
        'trouble',
        'qf',
        'Outline'
      },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all 'hide' just mean 'dimmed out'
          hide_dotfiles = false,
          hide_gitignored = false
        }
      },
      window = {
        mappings = {
          -- Regular mappings
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard'
          },
          ['O'] = {
            function(state)
              require('lazy.util').open(state.tree:get_node().path, { system = true })
            end,
            desc = 'Open with System Application'
          },
          ['P'] = { 'toggle_preview', config = { use_float = false } }
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander'
          },
          git_status = {
            symbols = {
              unstaged = '󰄱',
              staged = '󰱒'
            }
          }
        }
      }
    }
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = {
      snippetDir = '~/MEGA/'
    }
  },
  {
    'akinsho/toggleterm.nvim',
    config = true
  },
  { -- Needed by neotree
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    config = true
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {}
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {} -- your configuration
  },
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    config = function()
      require('tailwindcss-colorizer-cmp').setup({
        color_square_width = 2
      })
    end
  },
  -- Configurations for plugins installed using LazyExtras
  {
    'folke/snacks.nvim',
    opts = {
      explorer = { enabled = false }
    }
  },
  {
    'folke/noice.nvim',
    opts = {
      lsp = {
        hover = { silent = true }
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      inlay_hints = { enabled = false }
    }
  },
  -- Disabled plugins go here
  { -- Get rid of annoying pop-up from mini.ai
    'echasnovski/mini.ai',
    enabled = false
  },
  {
    'stevearc/conform.nvim',
    enabled = false
  },
  {
    'mfussenegger/nvim-lint',
    enabled = false
  }
  --- Might use again if needed.
  -- {
  --   'mfussenegger/nvim-lint',
  --   config = function()
  --     require('lint').linters_by_fit = {}
  --   end
  -- },
  -- {
  --   'iabdelkareem/csharp.nvim',
  --   dependencies = {
  --     'mfussenegger/nvim-dap'
  --   },
  --   config = function()
  --     require('csharp').setup({
  --       lsp = {
  --         omnisharp = { enable = false },
  --         roslyn = {
  --           enable = true,
  --           cmd_path = os.getenv('ROSLYN_LSP') .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
  --         }
  --       }
  --     })
  --   end
  -- }
}
