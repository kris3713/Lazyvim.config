-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- for :q command
vim.keymap.set('n', '<c-q>', ':q<cr>', { desc = 'quit neovim' })
