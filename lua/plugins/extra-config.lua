return {
  -- Configuration for plugins already installed by LazyExtras or by LazyVim (by default)
  {
    'folke/snacks.nvim',
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = false },
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
      win = { border = 'rounded' }
    },
    keys = {
      { '<leader>S', false }
    }
  },
  {
    'folke/noice.nvim',
    ---@module 'noice'
    ---@type NoiceConfig
    opts = {
      lsp = {
        hover = { silent = true },
        message = { silent = true }
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    ---@module 'lspconfig'
    ---@type lspconfig.Config
    opts = {
      -- Disable inlay hints
      inlay_hints = { enabled = false }
    }
  },
  {
    'akinsho/bufferline.nvim',
    ---@module 'bufferline'
    ---@type bufferline.Config
    opts = {
      options = {
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
    'mason-org/mason.nvim',
    ---@module 'mason',
    ---@type MasonSettings
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry'
      }
    }
  }
}
