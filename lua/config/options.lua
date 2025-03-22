-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remove annoying autoformat
vim.g.autoformat = false

-- Neovide options (continued in ./keymaps.lua)
vim.g.neovide_scale_factor = 1.0

-- Set font family and font size (For Neovide and Neovim-Qt)
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h16' }

-- Set softwrapping to always be true
vim.opt.wrap = true

-- -- Set leader key
-- vim.g.mapleader = ","

-- Change default cursor to a line
vim.opt.guicursor = 'i:ver25-iCursor'

-- Set lazyvim picker to fzf
vim.g.lazyvim_picker = 'fzf'

-- .NET development
vim.filetype.add({
  extension = {
    props = 'msbuild',
    tasks = 'msbuild',
    targets = 'msbuild',
  },
  pattern = {
    [ [[.*\..*proj]] ] = 'msbuild',
  },
})

vim.treesitter.language.register('xml', { 'msbuild' })
