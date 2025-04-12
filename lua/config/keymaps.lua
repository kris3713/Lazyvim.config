-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- current directory
local cwd = vim.fn.getcwd()
-- root directory
local root = LazyVim.root()

-- lsp keymaps
local lsp_keymaps = require('lazyvim.plugins.lsp.keymaps').get()

--- which-key.nvim
require('which-key').add {
  {
    '<leader>j',
    desc = 'Join code block'
  },
  {
    '<leader>m',
    desc = 'Split or Join code block with autodetect'
  }
}

--- Sets options for keymaps
---@param desc string
---@param silent? boolean
---@return table
local function opts(desc, silent)
  silent = silent or false
  return { desc = desc, silent = silent, noremap = true }
end

-- Neovide options
if vim.g.neovide then
  local other_opts = { nowait = false, noremap = false }

  -- Set zoom function for Neovide
  local function zoom(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-=>', function() zoom(1.25) end, other_opts)
  vim.keymap.set({ 'n', 'x', 'i' }, '<C-->', function() zoom(1/1.25) end, other_opts)
end

-- nvim-tree
local ntree_api = require('nvim-tree.api').tree
local function open_at_root() ntree_api.toggle({ path = root }) end
local function open_at_cwd() ntree_api.toggle({ path = cwd }) end

vim.keymap.set('n', '<leader>e', open_at_root, opts('Explorer nvim-tree (root)'))

vim.keymap.set('n', '<leader>E', open_at_cwd, opts('Explorer nvim-tree (cwd)'))

vim.keymap.set('n', '<leader>fe', open_at_root, opts('Explorer nvim-tree (root)'))

vim.keymap.set('n', '<leader>fE', open_at_cwd, opts('Explorer nvim-tree (cwd)'))

-- Map Ctrl-z to do nothing
vim.keymap.set({ 'n', 'x', 'i' }, '<C-z>', '<Nop>', opts('', true))

-- Map q to do nothing
vim.keymap.set('n', 'q', '<Nop>', opts('', true))
vim.keymap.set('x', 'q', '<Nop>', opts('', true))

-- Map quit command to Ctrl-q
vim.keymap.set('n', '<C-q>', function() vim.cmd('q') end, opts('Quit Neovim', true))

-- Map quit all command to Ctrl+Alt+q
vim.keymap.set('n', '<C-A-q>', function() vim.cmd('qa') end, opts('Quit all Neovim instances', true))

-- Change delete keymaps to "Delete without yanking"
vim.keymap.set('n', 'd', '"_x', opts('', true))
vim.keymap.set('n', '<Del>', '"_x', opts('', true))
vim.keymap.set('x', 'd', '"_x', opts('', true))
vim.keymap.set('x', '<Del>', '"_x', opts('', true))

-- Make it easier to paste
vim.keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', opts('', false))
vim.keymap.set({ 'i', 'c' }, '<S-Insert>', '<C-r>+', opts('', false))
vim.keymap.set('n', '<C-v>', '"+p', opts('', false))
vim.keymap.set('n', '<S-Insert>', '"+p', opts('', false))

-- actions-preview.nvim
local ap = require('actions-preview')

vim.keymap.set({ 'x', 'n' }, '<leader>xf', ap.code_actions, opts('Open Code Actions'))

lsp_keymaps[#lsp_keymaps + 1] = {
  '<leader>ca', ap.code_actions, desc = 'Open Code Actions', noremap = true
}

-- neogen
local ngen = require('neogen')

vim.keymap.set(
  'n', '<leader>N', function() ngen.generate() end, opts('Generate annotations', true)
)

-- Set softwrap to Alt + Z
vim.keymap.set(
  'n', '<A-z>', function() vim.cmd('set wrap!') end, opts('Toggle softwrap', true)
)

-- Make it easier to open LazyExtras
vim.keymap.set(
  'n', '<leader>L', function() vim.cmd('LazyExtras') end, opts('Open LazyExtras')
)

-- Make it easier to open Mason
vim.keymap.set(
  'n', '<leader>M', function() vim.cmd('Mason') end, opts('Open Mason')
)

-- auto-session
local ses = require('auto-session')

local function enable_auto_save()
  if not ses.DisableAutoSave then
    ses.DisableAutoSave(true)
    vim.cmd("echo 'Auto-save is disabled'")
  else
    ses.DisableAutoSave(false)
    vim.cmd("echo 'Auto-save is enabled'")
  end
end

vim.keymap.set(
  'n', '<leader>qf', function() vim.cmd('SessionSearch') end, opts('Select a session to load')
)

vim.keymap.set(
  'n', '<leader>qS', function() ses.SaveSession(cwd) end, opts('Restore session based on cwd')
)

vim.keymap.set(
  'n', '<leader>qs', function() ses.RestoreSession(cwd) end, opts('Restore last session based on cwd')
)

vim.keymap.set(
  'n', '<leader>qD', function() ses.DeleteSession(cwd) end, opts('Delete Session based on cwd')
)

vim.keymap.set(
  'n', '<leader>qd', enable_auto_save, opts('Toggle autosave')
)

-- Map the backwards indent to Shift + Tab
vim.keymap.set('i', '<S-Tab>', '<C-d>', opts('Backwards indent'))

-- toggleterm.nvim
local tt = require('toggleterm')

local function open_terminal()
  local terminals = require('toggleterm.terminal').get_all()
  if #terminals == 0 then
    tt.new(nil, root, 'horizontal')
  else
    tt.toggle_all()
  end
end

local function create_terminal()
  local terminals = require('toggleterm.terminal').get_all()
  if #terminals ~= 0 then
    tt.new(nil, root, 'horizontal')
  end
end

vim.keymap.set('n', '<C-/>', open_terminal, opts('Open a Terminal (if one is not open)'))

vim.keymap.set('n', '<C-\\>', create_terminal, opts('Create a new Terminal (if one is active)'))

-- NOTE: "?" is short for "Ctrl + Shift + /"
vim.keymap.set(
  'n', '<C-?>', function() tt.toggle_all() end, opts('Toggles all Terminal instances')
)

vim.keymap.set(
  'n', '<leader>ft', function() tt.new(nil, root, 'horizontal') end, opts('Open a Terminal (Root Dir)')
)

vim.keymap.set(
  'n', '<leader>fT', function() tt.new(nil, cwd, 'horizontal') end, opts('Open a Terminal (cwd)')
)

-- grug-far
local grug = require('grug-far')

local function grug_with_v_selection()
  grug.with_visual_selection({
    prefills = { paths = vim.fn.expand('%') }
  })
end

vim.keymap.set('v', '<leader>s/', grug_with_v_selection, opts('Search and Replace in current file'))

-- Keymap for built-in renaming
vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, opts('Rename'))

-- Yazi keymaps
local yz = require('yazi')

vim.keymap.set(
  'n', '<leader>Y', function() yz.yazi(yz.config) end, opts('Open yazi at the current file', true)
)

vim.keymap.set(
  'n', '<leader>cw', function() yz.yazi(yz.config, cwd, nil) end, opts('Open yazi in the cwd', true)
)

vim.keymap.set(
  'n', '<leader><up>', function() yz.toggle(yz.config) end, opts('Resume the last yazi session', true)
)

-- nvim-ufo
vim.keymap.set('n', 'zR', require('ufo').openAllFolds, opts('Open all folds'))

vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, opts('Close all folds'))

-- telescope-undo
vim.keymap.set('n', '<leader>U', function() vim.cmd('Telescope undo') end, opts('Telescope undo'))

--- lspsaga
-- Definition
vim.keymap.set('n', 'gt', function() vim.cmd.Lspsaga('peek_definition') end, opts('Peek definition'))

vim.keymap.set('n', 'gT', function() vim.cmd.Lspsaga('peek_type_definition') end, opts('Peek type definition'))

-- Hover Doc
local function hover_doc() vim.cmd.Lspsaga('hover_doc') end

lsp_keymaps[#lsp_keymaps + 1] = {
  'K', hover_doc, desc = 'Hover Doc', noremap = true
}

vim.keymap.set('n', '<Tab>', hover_doc, opts('Hover Doc'))

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

-- Aerial
vim.keymap.set('n', '<leader>O', function() require('aerial').toggle() end, opts('Outline'))

-- dropbar
local dropbar_api = require('dropbar.api')

vim.keymap.set('n', '<Leader>;', dropbar_api.pick, opts('Pick symbols in winbar'))

vim.keymap.set('n', '[;', dropbar_api.goto_context_start, opts('Go to start of current context'))

vim.keymap.set('n', '];', dropbar_api.select_next_context, opts('Select next context'))

-- refactoring.nvim (Overriding their functions because they are not working as expected)
vim.keymap.set(
  'n', '<leader>ri', function() vim.cmd.Refactor('inline_var') end, opts('Inline Variable')
)

vim.keymap.set(
  'n', '<leader>rb', function() vim.cmd.Refactor('extract_block') end, opts('Extract Block')
)

vim.keymap.set(
  'n', '<leader>rf', function() vim.cmd.Refactor('extract_block_to_file') end, opts('Extract Block To File')
)

vim.keymap.set(
  'v', '<leader>rf', function() vim.cmd.Refactor('extract_function') end, opts('Extract Function')
)

vim.keymap.set(
  'v', '<leader>rF', function() vim.cmd.Refactor('extract_function_to_file') end, opts('Extract Function To File')
)

vim.keymap.set(
  'v', '<leader>rx', function() vim.cmd.Refactor('extract_var') end, opts('Extract Variable')
)

-- treesj
vim.keymap.set(
  'n', '<leader>i', function() require('treesj').split() end, opts('Split code block')
)

-- Swap between fileformats
local function swap_fileformats()
  local fileformat = vim.bo.fileformat
  if fileformat == 'unix' then
    vim.o.fileformat = 'dos'
  elseif fileformat == 'dos' then
    vim.o.fileformat = 'mac'
  elseif fileformat == 'mac' then
    vim.o.fileformat = 'unix'
  end
end

vim.keymap.set('n', '<leader>fq', swap_fileformats, opts('Swap fileformats (unix, dos, mac)'))
