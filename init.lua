-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')
-- For Comment.nvim
require('Comment').setup()

-- Get rid of Neovim's stupid cursor change
local restore_cursor_augroup = vim.api.nvim_create_augroup('restore_cursor_shape_on_exit', {
  clear = true
})
vim.api.nvim_create_autocmd({ 'VimLeave' }, {
  group = restore_cursor_augroup,
  desc = 'restore the cursor shape on exit of neovim',
  command = 'set guicursor=a:ver20',
})

-- Set font family and font size (For Neovide and Neovim-Qt)
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h16' }
-- Set softwrapping to always be true
vim.opt.wrap = true

-- Set zoom function
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<c-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('n', '<c-->', function() change_scale_factor(1/1.25) end)

-- rainbow delimiters
-- This module contains a number of default definitions
local rainbow_delimiters = require('rainbow-delimiters')

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  strategy = {
    [''] = rainbow_delimiters.strategy['global'],
    vim = rainbow_delimiters.strategy['local']
  },
  query = {
    [''] = 'rainbow-delimiters',
    lua = 'rainbow-blocks'
  },
  priority = {
    [''] = 110,
    lua = 210
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

local hooks = require 'ibl.hooks'
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

