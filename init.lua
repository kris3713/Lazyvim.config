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
-- Set hovering to enable
vim.lsp.buf.hover()

-- Set zoom function
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<c-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('n', '<c-->', function() change_scale_factor(1/1.25) end)

-- rainbow delimiters
-- This module contains a number of default definitions
local rainbow_delimiters = require("rainbow-delimiters")

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
