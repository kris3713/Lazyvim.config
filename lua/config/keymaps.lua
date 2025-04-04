-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- current directory
local cwd = vim.fn.getcwd()
local root = LazyVim.root()

-- lsp keymaps
local lsp_keymaps = require('lazyvim.plugins.lsp.keymaps').get()

--- which-key.nvim
local wk = require('which-key')

wk.add {
  { -- auto-session.nvim
    mode = 'n',
    '<leader>S',
    group = 'auto-session',
    noremap = true
  }
}

-- Neovide options
if vim.g.neovide then
  local opts = { nowait = false, noremap = false }

  -- Set zoom function for Neovide
  local function zoom(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-=>', function() zoom(1.25) end, opts)
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-->', function() zoom(1/1.25) end, opts)
end

-- nvim-tree
local ntree_api = require('nvim-tree.api').tree

vim.keymap.set('n', '<leader>e', function() ntree_api.toggle({ path = root }) end, {
  desc = 'Explorer nvim-tree (root)', noremap = true
})

vim.keymap.set('n', '<leader>E', function() ntree_api.toggle({ path = cwd }) end, {
  desc = 'Explorer nvim-tree (cwd)', noremap = true
})

vim.keymap.set('n', '<leader>fe', function() ntree_api.toggle({ path = root }) end, {
  desc = 'Explorer nvim-tree (root)', noremap = true
})

vim.keymap.set('n', '<leader>fE', function() ntree_api.toggle({ path = cwd }) end, {
  desc = 'Explorer nvim-tree (cwd)', noremap = true
})

-- Map Ctrl-z to do nothing
vim.keymap.set({ 'n', 'x', 'i' }, '<C-z>', '<Nop>', {
  noremap = true, silent = true
})

-- Map q to do nothing
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'q', '<Nop>', { noremap = true, silent = true })

-- Map quit command to Ctrl-q
vim.keymap.set('n', '<C-q>', function() vim.cmd('q') end, {
  desc = 'Quit Neovim', noremap = true, silent = true
})

-- Map quit all command to Ctrl+Alt+q
vim.keymap.set('n', '<C-A-q>', function() vim.cmd('qa') end, {
  desc = 'Quit all Neovim instances', noremap = true, silent = true
})

-- Change delete keymaps to "Delete without yanking"
vim.keymap.set('n', 'd', '"_x', { silent = true, noremap = true })
vim.keymap.set('n', '<Del>', '"_x', { silent = true, noremap = true })
vim.keymap.set('x', 'd', '"_x', { silent = true, noremap = true })
vim.keymap.set('x', '<Del>', '"_x', { silent = true, noremap = true })

-- Make it easier to paste
vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', { noremap = true })
vim.keymap.set({ 'i', 'c' }, '<S-Insert>', '<C-r>+', { noremap = true })
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true })
vim.keymap.set('n', '<S-Insert>', '"+p', { noremap = true })

-- actions-preview.nvim
local ap = require('actions-preview')

vim.keymap.set({ 'x', 'n' }, '<leader>xf', ap.code_actions, {
  desc = 'Open Code Actions', noremap = true
})

lsp_keymaps[#lsp_keymaps + 1] = {
  '<leader>ca', ap.code_actions, desc = 'Open Code Actions', noremap = true
}

-- neogen
local ngen = require('neogen')

vim.keymap.set('n', '<Leader>N', function() ngen.generate() end, {
  desc = 'Generate annotations', remap = true, silent = true
})

-- Set softwrap to Alt + Z
vim.keymap.set('n', '<A-z>', function() vim.cmd('set wrap!') end, {
  desc = 'Toggle softwrap.', noremap = true, silent = true
})

-- Make it easier to open LazyExtras
vim.keymap.set('n', '<leader>L', function() vim.cmd('LazyExtras') end, {
  desc = 'Open LazyExtras', silent = true, remap = true
})

-- Make it easier to open Mason
vim.keymap.set('n', '<leader>M', function() vim.cmd('Mason') end, {
  desc = 'Open Mason', silent = true, remap = true
})

-- auto-session
local ses = require('auto-session')

vim.keymap.set('n', '<leader>SS', function () vim.cmd('SessionSearch') end, {
    desc = 'Search Saved Sessions', silent = true, noremap = true
})

vim.keymap.set('n', '<leader>Ss', function() ses.SaveSession(cwd) end, {
  desc = 'Save Session', silent = true, noremap = true
})

-- Set a keymap for deleting the
-- saved session based on the cwd (Current Working Directory)
vim.keymap.set('n', '<leader>Sd', function() ses.DeleteSession(cwd) end, {
  desc = 'Delete Session based on cwd', silent = true, noremap = true
})

-- Map the backwards indent to Shift + Tab
vim.keymap.set('i', '<S-Tab>', '<C-d>', {
  noremap = true, silent = true
})

-- toggleterm.nvim
local tt = require('toggleterm')

vim.keymap.set({ 'n', 'x' }, '<C-/>', function() tt.new(nil, nil, 'horizontal') end, {
  desc = 'Open a new terminal instance', remap = true
})

vim.keymap.set({ 'n', 'x' }, '<C-\\>', function() tt.toggle_all() end, {
  desc = 'Toggles an active terminal instance', remap = true
})

-- grug-far
local grug = require('grug-far')

vim.keymap.set({ 'n', 'x' }, '<leader>s/', function()
  grug.with_visual_selection({
    prefills = { paths = vim.fn.expand('%') }
  })
end, { desc = 'Search and Replace in current file', noremap = true })

-- Keymap for built-in renaming
vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, {
  desc = 'Rename', noremap = true
})

-- Yazi keymaps for later.
local yz = require('yazi')

vim.keymap.set('n', '<leader>Y', function() yz.yazi(yz.config) end, {
  desc = 'Open yazi at the current file', noremap = true, silent = true
})

vim.keymap.set('n', '<leader>cw', function() yz.yazi(yz.config, cwd, nil) end, {
  desc = "Open yazi in the cwd", noremap = true, silent = true
})

vim.keymap.set('n', '<leader><up>', function() yz.toggle(yz.config) end, {
  desc = 'Resume the last yazi session', noremap = true, silent = true
})

-- nvim-ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, {
  desc = 'Open all folds', noremap = true
})
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, {
  desc = 'Close all folds', noremap = true
})

-- telescope-undo
vim.keymap.set('n', '<leader>U', function() vim.cmd('Telescope undo') end , {
  desc = 'Telescope undo', noremap = true
})

--- lspsaga
-- Definition
vim.keymap.set('n', 'gt', function() vim.cmd.Lspsaga('peek_definition') end, {
  desc = 'Peek definition', noremap = true
})

vim.keymap.set('n', 'gT', function() vim.cmd.Lspsaga('peek_type_definition') end, {
  desc = 'Peek type definition', noremap = true
})

-- Outline
vim.keymap.set('n', '<leader>O', function() vim.cmd.Lspsaga('outline') end, {
  desc = 'Outline', noremap = true
})

-- Hover Doc
lsp_keymaps[#lsp_keymaps + 1] = {
  'K', function() vim.cmd.Lspsaga('hover_doc') end, desc = 'Hover Doc', noremap = true
}

-- Diagnostics
lsp_keymaps[#lsp_keymaps + 1] = {
  '<leader>cd', function() vim.cmd.Lspsaga('show_line_diagnostics') end, desc = 'Line Diagnostics', noremap = true
}
--- lspsaga

-- omnisharp
local f_type = vim.bo.filetype

if (f_type == 'cs' or f_type == 'vb') then
  local omni = require('omnisharp_extended')

  lsp_keymaps[#lsp_keymaps + 1] = {
    'gy', omni.telescope_lsp_type_definition, desc = 'Goto T[y]pe Definition (omnisharp)', noremap = true
  }

  lsp_keymaps[#lsp_keymaps + 1] = {
    'gr', omni.telescope_lsp_references, desc = 'References (omnisharp)', noremap = true
  }

  lsp_keymaps[#lsp_keymaps + 1] = {
    'gI', omni.telescope_lsp_implementation, desc = 'Implementation (omnisharp)', noremap = true
  }
end
