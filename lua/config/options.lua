-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remove annoying autoformat
vim.g.autoformat = false

--- Neovide options
local scale_factor_exists = pcall(function()
  return vim.g.neovide_scale_factor
end)

-- Check if the neovide_scale_factor variable exists
if scale_factor_exists then
  -- Used for custom scaling (zooming) in Neovide
  vim.g.neovide_scale_factor = 1.0
end

-- Set font family and font size (For Neovide and Neovim-Qt)
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h16' }

-- Set softwrapping to always be true
vim.opt.wrap = true

-- -- Set leader key
-- vim.g.mapleader = ","

-- Change default cursor to a line
vim.opt.guicursor = 'i:ver25-iCursor'

-- Set lazyvim picker to telescope
vim.g.lazyvim_picker = 'telescope'

-- Enable smooth scrolling
vim.o.smoothscroll = true

-- Set lualine status
vim.g.lualine_laststatus = 2

-- Set lazyvim completion engine
vim.g.lazyvim_cmp = 'nvim-cmp'

-- .NET development
vim.filetype.add({
  extension = {
    props = 'msbuild',
    tasks = 'msbuild',
    targets = 'msbuild'
  },
  pattern = {
    [ [[.*\..*proj]] ] = 'msbuild'
  },
})

vim.treesitter.language.register('xml', { 'msbuild' })

-- Set listchars
vim.o.listchars = 'tab:>-,trail:·,extends:>,precedes:<,space:·,nbsp:+'

-- Enable list
vim.o.list = true

-- Change current directory when opening a file
vim.o.acd = true

-- Remove snippets from completion that are not related to the current file.
vim.g.lazyvim_mini_snippets_in_completion = false

-- Ensure the encoding is always UTF-8
vim.o.encoding = 'utf-8'


-- For mouse
vim.o.mousemoveevent = true
vim.opt.mouse = 'a'

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
