return {
  -- Configuration for plugins already installed by LazyExtras
  {
    'folke/snacks.nvim',
    opts = {
      explorer = { enabled = false }
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
    opts = {
      inlay_hints = { enabled = false }
    }
  }
}
