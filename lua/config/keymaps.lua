-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set zoom function
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<c-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('n', '<c-->', function() change_scale_factor(1/1.25) end)

-- Map Ctrl-Z to do nothing
vim.keymap.set('n', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- for quit command
vim.keymap.set('n', '<c-q>', ':q<cr>', { desc = 'quit neovim' })
