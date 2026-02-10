-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable 24 bit color
vim.opt.termguicolors = true

-- Remove annoying autoformat
vim.g.autoformat = false

-- Improved sessionoptions
vim.o.sessionoptions = 'buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Prevent macro recording from interfering with plugin keymaps
vim.o.timeoutlen = 2000
vim.o.ttimeoutlen = 0

--- @diagnostic disable-next-line: undefined-field
if vim.g.neovide then
  -- Set font family and font size (For Neovide)
  vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h14' }
end

-- Set softwrapping to always be true
vim.opt.wrap = true

-- Ensure all indents are spaces and have a width of 2
vim.o.expandtab = true

-- Enable either shiftwidth or tabstop.
do
  local bufnr = vim.api.nvim_get_current_buf()

  if (vim.bo[bufnr].shiftwidth >= 4) or (vim.bo[bufnr].tabstop >= 4) then
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].tabstop = 4
  else
    vim.bo[bufnr].shiftwidth = 2
    vim.bo[bufnr].tabstop = 2
  end
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
  pattern = {
    [ [[.*\..*proj]] ] = 'msbuild'
  }
}

vim.treesitter.language.register('xml', { 'msbuild' })

-- `composer.lock`
vim.filetype.add {
  filename = {
    ['composer.lock'] = 'json'
  }
}

-- Set filetype to Systemd for Systemd unit files
do
  local systemd_unit_extensions = { -- Credit to @magnuslarsen
    -- Systemd unit files
    'service',
    'socket',
    'timer',
    'mount',
    'automount',
    'swap',
    'target',
    'path',
    'slice',
    'scope',
    'device',
    -- Podman Quadlet files
    'container',
    'volume',
    'network',
    'kube',
    'pod',
    'build',
    'image'
  }

  local extension_map = {}
  for _, exts in ipairs(systemd_unit_extensions) do
    extension_map[exts] = 'systemd'
  end

  vim.filetype.add { extension = extension_map }
end

-- Set listchars
do
  ---@param name string
  ---@return integer
  local function create_augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
  end

  local create_autocmd = vim.api.nvim_create_autocmd

  local set_hl = vim.api.nvim_set_hl

  local tab = '󰌒'
  local space = '·'
  local blankspace = '␣'

  vim.opt.listchars:append {
    lead = space,
    tab = '|' .. tab,
    multispace = space,
    nbsp = blankspace,
    space = space,
    trail = space
  }

  local function error_hl()
    set_hl(0, 'TrailingWhitespace', { link = 'Error' })
  end

  vim.cmd([[match TrailingWhitespace /\\s\\+\$/]])

  create_autocmd('InsertEnter', {
    group = create_augroup('hl_trailing_whitespace_pt_1'),
    callback = function()
      vim.opt.listchars.trail = nil
      set_hl(0, 'TrailingWhitespace', { link = 'Whitespace' })
    end
  })

  create_autocmd('InsertLeave', {
    group = create_augroup('hl_trailing_whitespace_pt_2'),
    callback = function()
      vim.opt.listchars.trail = space
      error_hl()
    end
  })
end

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
vim.o.mouse = 'a'
vim.o.mousemodel = 'popup'

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- harper:ignore
vim.o.foldlevelstart = 99
vim.o.foldenable = true

--- @diagnostic disable-next-line: assign-type-mismatch
-- Disable netrw
vim.g.loaded_netrw = false
--- @diagnostic disable-next-line: assign-type-mismatch
vim.g.loaded_netrwPlugin = false

-- Stop line numbers from shifting forward and back
vim.o.signcolumn = 'yes:2'

-- Ensure Neovim always create an undo file
vim.o.undofile = true

-- Ensure the relative line number is always shown
vim.o.relativenumber = false

-- Enable smartindent
vim.o.smartindent = true
-- harper:ignore
-- vim.o.autoindent = true

-- Configure Neovim's diagnostics
vim.diagnostic.config {
  underline = true,
  signs = true,
  virtual_text = false,
  virtual_lines = false,
  update_in_insert = true
}
