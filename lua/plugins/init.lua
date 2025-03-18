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
      'folke/which-key.nvim'
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
  { 'numToStr/Comment.nvim' },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup()
    end
  },
  { 'HiPhish/rainbow-delimiters.nvim' },
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
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim'
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
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim'
    },
    cmd = 'Neotree',
    init = function ()
      vim.api.nvim_create_autocmd('BufNewFile', {
        group    = vim.api.nvim_create_augroup('RemoteFile', { clear = true }),
        callback = function()
          local f = vim.fn.expand('%:p')
          for _, v in ipairs { 'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync' } do
            local p = v .. '://'
            if string.sub(f, 1, #p) == p then
              vim.cmd[[
                unlet g:loaded_netrw
                unlet g:loaded_netrwPlugin
                runtime! plugin/netrwPlugin.vim
                silent Explore %
              ]]
              vim.api.nvim_clear_autocmds { group = 'RemoteFile' }
              break
            end
          end
        end
      })
    end,
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all 'hide' just mean 'dimmed out'
          hide_dotfiles = false,
          hide_gitignored = false
        }
      }
    }
  },
  { 'neovim/nvim-lspconfig' },
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter'
  },
  { 'aznhe21/actions-preview.nvim' },
  { 'nanotee/zoxide.vim' },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvimtools/none-ls-extras.nvim' },
    event = 'VeryLazy'
  },
  {
    'nvim-pack/nvim-spectre'
  }
}
