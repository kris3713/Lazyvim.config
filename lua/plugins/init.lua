return {
  -- No config plugins go here
  'HiPhish/rainbow-delimiters.nvim',
  'aznhe21/actions-preview.nvim',
  'nanotee/zoxide.vim',
  'numToStr/Comment.nvim',
  'nvim-tree/nvim-web-devicons',
  'MunifTanjim/nui.nvim',
  'nvimtools/none-ls-extras.nvim',
  -- Plugins with configs go here
  -- {
  --   'roobert/surround-ui.nvim',
  --   dependencies = {
  --     'kylechui/nvim-surround'
  --   },
  --   config = function()
  --     require('surround-ui').setup {
  --       root_key = 'S'
  --     }
  --   end
  -- },
  -- {
  --   'kylechui/nvim-surround',
  --   version = '*', -- Use for stability; omit to use `main` branch for the latest features
  --   event = 'VeryLazy',
  --   config = function()
  --     require('nvim-surround').setup()
  --   end
  -- },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup()
    end
  },
  { -- Activate csharp.nvim
    'iabdelkareem/csharp.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
      'Tastyep/structlog.nvim' -- Optional, but highly recommended for debugging
    },
    config = function ()
      -- require('mason').setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require('csharp').setup {
        lsp = {
          omnisharp = { enable = false },
          roslyn = {
            enable = true,
            cmd_path = os.getenv('ROSLYN_LSP') .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
          }
        }
      }
    end
  },
  { -- Activate lazygit.nvim
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile'
    }
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '/' }
    }
  },
  { -- Important for whitespace trimming
    'cappyzawa/trim.nvim',
    opts = {}
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true
  },
  {
    'folke/snacks.nvim',
    --- @module 'snacks'
    --- @type snacks.Config
    opts = {
      notifier = { enabled = true },
      -- show hidden files in snacks.explorer
      picker = {
        sources = {
          explorer = {
            -- show hidden files like .env
            hidden = true,
            -- show files ignored by git like node_modules
            ignored = true,
            exclude = { 'node_modules', '.git' }
          }
        }
      }
    }
  },
  {
    'akinsho/bufferline.nvim',
    opts = function(_, opts)
      if (vim.g.colors_name or ''):find('catppuccin') then
        opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
      end
    end
  },
  {
    'catppuccin/nvim',
    lazy = true,
    name = 'catppuccin',
    opts = {
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        flash = true,
        fzf = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' }
          }
        },
        neotree = true,
        notify = true,
        semantic_tokens = true,
        snacks = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true
      }
    }
  },
  {
    'antosha417/nvim-lsp-file-operations',
    config = function ()
      require('lsp-file-operations').setup()
    end
  }
}
