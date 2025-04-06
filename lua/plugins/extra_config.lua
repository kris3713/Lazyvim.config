return {
  -- Configuration for plugins already installed by LazyExtras
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
            cmd = { 'delta', '--paging=never' }
          },
          man_pager = 'nvim +Man!'
        }
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
    opts = {
      inlay_hints = { enabled = false }
    }
  }
}
