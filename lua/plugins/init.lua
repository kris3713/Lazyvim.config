return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin-macchiato'
    }
  },
  {
    'roobert/surround-ui.nvim',
    dependencies = {
      'kylechui/nvim-surround',
      'folke/which-key.nvim',
    },
    config = function()
      require('surround-ui').setup {
        root_key = 'S'
      }
    end
  },
  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup()
    end
  },
  {
    'HiPhish/rainbow-delimiters.nvim'
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module 'ibl'
    ---@type ibl.config
    opts = {}
  },
  { -- Activate csharp.nvim
    'iabdelkareem/csharp.nvim',
    dependencies = {
      'williamboman/mason.nvim', -- Required, automatically installs omnisharp
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
            cmd_path = '/home/kris/DO-NOT-DELETE/roslyn-lsp/Microsoft.CodeAnalysis.LanguageServer.dll'
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
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' }
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
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim'
    },
    config = function ()
      require('nvim-neo-tree/neo-tree.nvim').setup {
        filesystem = {
          filtered_items = {
            visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
            hide_dotfiles = false,
            hide_gitignored = false,
            hijack_netrw_behavior = 'open_current'
          }
        }
      }
    end
  }
}
