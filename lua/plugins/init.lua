return {
  { -- Set colorscheme
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin-macchiato'
    }
  },
  { -- Activate roobert/surround-ui.nvim
    'roobert/surround-ui.nvim',
    dependencies = {
      'kylechui/nvim-surround',
      'folke/which-key.nvim',
    },
    config = function()
      require('surround-ui').setup({
        root_key = 'S'
      })
    end
  },
  { -- Activate kylechui/nvim-surround
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  { -- Activate numToStr/Comment
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    }
  },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup {}
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
  {
    'iabdelkareem/csharp.nvim',
    dependencies = {
      'williamboman/mason.nvim', -- Required, automatically installs omnisharp
      'mfussenegger/nvim-dap',
      'Tastyep/structlog.nvim' -- Optional, but highly recommended for debugging
    },
    config = function ()
      -- require('mason').setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require('csharp').setup({
        lsp = {
          omnisharp = { enable = false },
          roslyn = {
            enable = true,
            cmd_path = '/home/kris/DO-NOT-DELETE/roslyn-lsp/Microsoft.CodeAnalysis.LanguageServer.dll'
          }
        }
      })
    end
  }
}
