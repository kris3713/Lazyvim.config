-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set zoom function
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set('n', '<C-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('n', '<C-->', function() change_scale_factor(1/1.25) end)
vim.keymap.set('x', '<C-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('x', '<C-->', function() change_scale_factor(1/1.25) end)
vim.keymap.set('i', '<C-=>', function() change_scale_factor(1.25) end)
vim.keymap.set('i', '<C-->', function() change_scale_factor(1/1.25) end)

-- Map Ctrl-z to do nothing
vim.keymap.set('n', '<C-z>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', '<C-z>', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('i', '<C-z>', '<Nop>', { noremap = true, silent = true })

-- Map q to do nothing
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'q', '<Nop>', { noremap = true, silent = true })

-- Map quit command to Ctrl-q
vim.keymap.set('n', '<C-q>', ':q<cr>', {
  desc = 'Quit neovim', noremap = true, silent = true
})

-- Map c to yank command
vim.keymap.set('n', 'c', ':y<cr>', { noremap = true })
vim.keymap.set('x', 'c', ':y<cr>', { noremap = true })

-- Change delete keymaps to "Delete without yanking"
vim.keymap.set('n', 'd', '"_x', { noremap = true })
vim.keymap.set('n', '<Del>', '"_x', { noremap = true })
vim.keymap.set('x', 'd', '"_x', { noremap = true })
vim.keymap.set('x', '<Del>', '"_x', { noremap = true })

-- Make it easier to paste in INSERT mode
vim.keymap.set('i', '<C-v>', '<C-r>+')
vim.keymap.set('i', '<S-Insert>', '<C-r>+')

-- Change keybin ld
