-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remove annoying autoformat
vim.g.autoformat = false

-- Improved sessionoptions
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

if vim.g.neovide then
  -- Set font family and font size (For Neovide)
  vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h14' }
end

-- Set softwrapping to always be true
vim.opt.wrap = true

-- Ensure all indents are spaces and have a width of 2
vim.o.expandtab = true

local bufnr = vim.api.nvim_get_current_buf()

if vim.bo[bufnr].shiftwidth >= 4 or vim.bo[bufnr].tabstop >= 4 then
  vim.o.shiftwidth = 4
  vim.o.tabstop = 4
else
  vim.o.shiftwidth = 2
  vim.o.tabstop = 2
end

-- -- Set leader key
-- vim.g.mapleader = ","

-- Change the default cursor (for Insert mode) to a vertical line
vim.opt.guicursor = 'i:ver25-iCursor'

-- Set lazyvim picker to telescope
vim.g.lazyvim_picker = 'telescope'

-- Enable smooth scrolling
vim.o.smoothscroll = true

-- Set lualine status
vim.g.lualine_laststatus = 2

-- Set lazyvim completion engine
vim.g.lazyvim_cmp = 'nvim-cmp'

--- Custom filetypes
-- `msbuild`
vim.filetype.add {
  extension = {
    props = 'msbuild',
    tasks = 'msbuild',
    targets = 'msbuild'
  },
  pattern = { [ [[.*\..*proj]] ] = 'msbuild' }
}

-- `yaml.docker-compose`
vim.filetype.add {
  filename = {
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose'
  }
}

-- `composer.lock`
vim.filetype.add {
  filename = {
    ['composer.lock'] = 'json'
  }
}

vim.treesitter.language.register('xml', { 'msbuild' })

-- Set listchars
vim.o.listchars = 'tab:󰌒 ,trail:·,space:·,nbsp:+'

-- Enable list
vim.o.list = true

-- Change current directory when opening a file
vim.o.acd = true

-- Remove snippets from completion that are not related to the current file.
vim.g.lazyvim_mini_snippets_in_completion = false

-- Ensure the encoding is always UTF-8
vim.o.encoding = 'utf-8'

-- Mouse support
vim.o.mousemoveevent = true
vim.opt.mouse = 'a'

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Disable netrw
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

-- Stop line numbers from shifting forward and back
vim.o.signcolumn = 'yes:2'

-- Ensure Neovim always create an undo file
vim.o.undofile = true

-- Ensure the relative line number is always shown
vim.o.relativenumber = false

-- Enable smartindent
vim.o.smartindent = true
-- vim.o.autoindent = true

-- LSP configs (That can't be manually enabled in lsp.lua)
local lsps = {
  'kotlin_lsp'
}

for _, name in ipairs(lsps) do
  vim.lsp.enable(name)
end
