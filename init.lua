-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')
-- For Comment.nvim
require('Comment').setup()

-- Set font family and font size (For Neovide and Neovim-Qt)
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h16' }
-- Set softwrapping to always be true
vim.opt.wrap = true

-- rainbow delimiters
-- This module contains a number of default definitions
local rainbow_delimiters = require('rainbow-delimiters')

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local'],
    c_sharp = rainbow_delimiters.strategy['local']
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks',
    c_sharp = 'rainbow-delimiters'
  },
  priority = {
    [''] = 110,
    lua = 210,
    c_sharp = 210
  },
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan'
  }
}

-- indent blankline
local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowViolet',
  'RainbowCyan'
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
end)

require('ibl').setup { indent = { highlight = highlight } }

-- Add parsing for csharp
require('nvim-treesitter.parsers').ft_to_lang('cs')

require('trim').setup({
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {"markdown"},

  -- if you want to remove multiple blank lines
  patterns = {
    [[%s/\(\n\n\)\n\+/\1/]],   -- replace multiple blank lines with a single line
  },

  -- if you want to disable trim on write by default
  trim_on_write = true,

  -- highlight trailing spaces
  highlight = true
})

-- Change default cursor to a line
vim.opt.guicursor = 'n:ver25-iCursor'

-- cspell.nvim
-- local cspell = require('davidmh/cspell.nvim')
-- require("null-ls").setup {
--     sources = {
--         cspell.diagnostics,
--         cspell.code_actions,
--     }
-- }
