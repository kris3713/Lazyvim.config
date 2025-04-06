return {
  -- Configuration for plugins already installed by LazyExtras
  {
    'folke/snacks.nvim',
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = false },
      scratch = { enabled = false },
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
      }
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
    opts = {} -- For later configuration
  }
}
