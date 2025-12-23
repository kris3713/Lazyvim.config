-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---@diagnostic disable: missing-fields
-- which-key.nvim
require('which-key').add {
  --- @diagnostic disable-next-line: assign-type-mismatch
  { '<leader>bq', desc = 'Sort by' },
  --- @diagnostic disable-next-line: assign-type-mismatch
  (function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].filetype == 'man' then
      --- @diagnostic disable-next-line: missing-fields
      ---@type wk.Mapping
      return { 'gO', desc = 'Open table of contents' }
    end

    --- @diagnostic disable-next-line: missing-fields
    ---@type wk.Mapping
    return { 'gO', desc = 'Open document symbols' }
  end)()
}


---Sets options for keymaps
---@param desc string
---@param silent boolean?
---@return vim.keymap.set.Opts
local function opts(desc, silent)
  silent = silent or false
  ---@type vim.keymap.set.Opts
  return { desc = desc, silent = silent, noremap = true }
end


-- All modes (except TERMINAL 't')
local all_modes = { 'n', 'x', 'i' }


-- `vim.keymap`
local vim_keymap = vim.keymap


--- @diagnostic disable-next-line: undefined-field
-- Neovide options
if vim.g.neovide then
  ---@type number
  vim.g.neovide_scale_factor = 1.0

  local other_opts = { nowait = false, noremap = false }

  --- Set zoom function for Neovide
  ---@param delta number
  local function zoom(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Using a font with ligatures can make the text appear confusing to some people, like myself.
  -- That is why I am using the concatenation operator (..) to make the keymaps more readable.
  vim_keymap.set(all_modes, '<C-=' .. '>', function() zoom(1.25) end, other_opts)
  vim_keymap.set(all_modes, '<C--' .. '>', function() zoom(1/1.25) end, other_opts)
end


-- nvim-tree
do
  -- Open nvim-tree at root
  local function open_at_root()
    local api = require('nvim-tree.api')
    api.tree.toggle { path = LazyVim.root() }
  end

  -- Open nvim-tree at CWD
  local function open_at_cwd()
    local api = require('nvim-tree.api')
    api.tree.toggle { path = vim.fn.getcwd() }
  end

  -- Change root to CWD for nvim-tree
  local function change_root_to_global_cwd()
    local api = require('nvim-tree.api')
    local global_cwd = vim.fn.getcwd(-1, -1)
    api.tree.change_root(global_cwd)
  end

  -- Focus on currently opened file in nvim-tree
  local function find_opened_file()
    local api = require('nvim-tree.api')
    api.tree.find_file { update_root = false, open = true, focus = true }
  end

  vim_keymap.set('n', '<leader>e', open_at_root, opts('nvim-tree: Explorer nvim-tree (root)'))
  vim_keymap.set('n', '<leader>E', open_at_cwd, opts('nvim-tree: Explorer nvim-tree (cwd)'))
  vim_keymap.set('n', '<leader>fe', open_at_root, opts('nvim-tree: Explorer nvim-tree (root)'))
  vim_keymap.set('n', '<leader>fE', open_at_cwd, opts('nvim-tree: Explorer nvim-tree (cwd)'))
  vim_keymap.set('n', '<leader>fC', change_root_to_global_cwd, opts('nvim-tree: Change root to global cwd (nvim-tree)'))
  vim_keymap.set('n', '<leader>fd', find_opened_file, opts('nvim-tree: Focus on currently opened file'))
end


-- Map Ctrl-z to do nothing
vim_keymap.set(all_modes, '<C-z>', '<Nop>', opts('', true))


-- Map q to do nothing
vim_keymap.set({ 'n', 'x' }, 'q', '<Nop>', opts('', true))


-- Map alt + q to macro recording
vim_keymap.set({ 'n', 'x' }, 'Q', 'q', opts('Record macro'))


-- Map quit command to Ctrl-q
vim_keymap.set('n', '<C-q>', function() vim.cmd('q') end, opts('Quit Neovim', true))


-- Map quit all command to Ctrl+Alt+q
vim_keymap.set('n', '<C-A-q>', function() vim.cmd('qa') end, opts('Quit all Neovim instances', true))


-- Change delete keymaps to "Delete without yanking"
vim_keymap.set('n', 'd', '"_x', opts('', true))
vim_keymap.set('n', '<Del>', '"_x', opts('', true))
vim_keymap.set('x', 'd', '"_x', opts('', true))
vim_keymap.set('x', '<Del>', '"_x', opts('', true))


-- Make it easier to paste
vim_keymap.set({ 'i', 'c' }, '<C-v>', '<C-r>+', opts('', false))
vim_keymap.set({ 'i', 'c' }, '<S-Insert>', '<C-r>+', opts('', false))
vim_keymap.set('n', '<C-v>', '"+p', opts('', false))
vim_keymap.set('n', '<S-Insert>', '"+p', opts('', false))


-- Switch between Tabs or Spaces
do
  local function switch_indent_style()
    local bufnr = vim.api.nvim_get_current_buf()
    require('functions.switch_indent_style').switch_indent_style(bufnr)
  end

  vim_keymap.set('n', '<leader>\\', switch_indent_style, opts('Switch between Tabs or Spaces'))
end


-- actions-preview.nvim
do
  local ap = require('actions-preview')

  vim_keymap.set({ 'x', 'n' }, '<leader>xf', ap.code_actions, opts('Open Code Actions'))
end


-- neogen
do
  local neogen = require('neogen')

  vim_keymap.set('n', '<leader>N', neogen.generate, opts('Generate annotations', true))
end


-- Set softwrap to Alt + Z
vim_keymap.set('n', '<A-z>', function() vim.cmd('set wrap!') end, opts('Toggle softwrap', true))


-- Make it easier to open LazyExtras
vim_keymap.set('n', '<leader>L', function() vim.cmd('LazyExtras') end, opts('Open LazyExtras'))


-- Make it easier to open Mason
vim_keymap.set('n', '<leader>M', function() vim.cmd('Mason') end, opts('Open Mason'))


-- auto-session
do
  local function save_session()
    local auto = require('auto-session')
    auto.save_session(vim.fn.getcwd())
  end

  local function restore_session()
    local auto = require('auto-session')
    auto.restore_session(vim.fn.getcwd())
  end

  vim_keymap.set('n', '<leader>qf', function() vim.cmd('AutoSession search') end, opts('Select a session to load/delete'))
  vim_keymap.set('n', '<leader>qS', save_session, opts('Save session based on cwd'))
  vim_keymap.set('n', '<leader>qs', restore_session, opts('Restore last session based on cwd'))
  vim_keymap.set('n', '<leader>qd', function() vim.cmd('AutoSession toggle') end, opts('Toggle autosave'))
end


-- Map the backwards/inverse indent to Shift + Tab
vim_keymap.set('i', '<S-Tab>', '<C-d>', opts('Backwards/Inverse indent (INSERT mode)'))
vim_keymap.set({ 'n', 'x' }, '<S-Tab>', '<S-Tab>', opts('Backwards/Inverse indent'))


-- toggleterm.nvim
do
  local function open_terminal()
    local tt = require('toggleterm')
    local terminals = require('toggleterm.terminal').get_all()
    if #terminals == 0 then tt.new(nil, LazyVim.root(), 'horizontal')
    else tt.toggle_all() end
  end

  local function create_terminal()
    local tt = require('toggleterm')
    local terminals = require('toggleterm.terminal').get_all()
    if #terminals ~= 0 then tt.new(nil, LazyVim.root(), 'horizontal') end
  end

  local function toggle_all_terminals()
    local tt = require('toggleterm')
    tt.toggle_all()
  end

  local function open_terminal_in_root()
    local tt = require('toggleterm')
    tt.new(nil, LazyVim.root(), 'horizontal')
  end

  local function open_terminal_in_cwd()
    local tt = require('toggleterm')
    tt.new(nil, vim.fn.getcwd(), 'horizontal')
  end

  vim_keymap.set({ 'n', 't' }, '<C-/>', open_terminal, opts('Open a Terminal (if one is not open)'))
  vim_keymap.set('n', '<C-\\>', create_terminal, opts('Create a new Terminal (if one is active)'))
  -- NOTE: "?" is short for "Ctrl + Shift + /"
  vim_keymap.set('n', '<C-?>', toggle_all_terminals, opts('Toggles all Terminal instances'))
  vim_keymap.set('n', '<leader>ft', open_terminal_in_root, opts('Open a Terminal (Root Dir)'))
  vim_keymap.set('n', '<leader>fT', open_terminal_in_cwd, opts('Open a Terminal (cwd)'))
end


-- grug-far
do
  local grug = require('grug-far')

  local function grug_with_v_selection()
    grug.with_visual_selection({
      prefills = { paths = vim.fn.expand('%') }
    })
  end

  --TODO: Add some more keymaps more normal mode

  vim_keymap.set('v', '<leader>s/', grug_with_v_selection, opts('Search and Replace in current file'))
end


-- Keymap for built-in renaming
vim_keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts('Rename'))


-- Yazi keymaps
do
  local function open_at_current_file()
    local yz = require('yazi')
    yz.yazi(yz.config)
  end

  local function open_in_cwd()
    local yz = require('yazi')
    yz.yazi(yz.config, vim.fn.getcwd(), nil)
  end

  local function resume_last_session()
    local yz = require('yazi')
    yz.toggle(yz.config)
  end

  vim_keymap.set('n', '<leader>Y', open_at_current_file, opts('Open yazi at the current file', true))
  vim_keymap.set('n', '<leader>cw', open_in_cwd, opts('Open yazi in the cwd', true))
  vim_keymap.set('n', '<leader><up>', resume_last_session, opts('Resume the last yazi session', true))
end


-- nvim-ufo
do
  local ufo = require('ufo')

  vim_keymap.set('n', 'zR', ufo.openAllFolds, opts('Open all folds'))
  vim_keymap.set('n', 'zM', ufo.closeAllFolds, opts('Close all folds'))
end


-- lspsaga
vim_keymap.set('n', 'gt', function() vim.cmd('Lspsaga peek_definition') end, opts('Peek definition'))
vim_keymap.set('n', 'gT', function() vim.cmd('Lspsaga peek_type_definition') end, opts('Peek type definition'))


-- -- hover.nvim
-- do
--   local hover = require('hover')
--
--   vim_keymap.set('n', '<Tab>', hover.open, opts('Hover Doc'))
--   -- vim_keymap.set('n', '<C-p>', function() hover.switch('previous', {}) end, opts('hover.nvim (Previous source)'))
--   -- vim_keymap.set('n', '<C-n>', function() hover.switch('next', {}) end, opts('hover.nvim (Next source)'))
-- end

-- pretty_hover
do
  local function pretty_hover__hover()
    local pretty_hover = require('pretty_hover')
    pretty_hover.hover {}
  end

  vim_keymap.set('n', '<Tab>', pretty_hover__hover, opts('Hover Doc'))
end


-- Aerial
do
  local function aerial_toggle()
    local aerial = require('aerial')
    aerial.toggle {}
  end

  vim_keymap.set('n', '<leader>O', aerial_toggle, opts('Outline'))
end


-- dropbar
do
  local dropbar_api = require('dropbar.api')

  vim_keymap.set('n', '<Leader>;', dropbar_api.pick, opts('Pick symbols in winbar'))
  vim_keymap.set('n', '[;', dropbar_api.goto_context_start, opts('Go to start of current context'))
  vim_keymap.set('n', '];', dropbar_api.select_next_context, opts('Select next context'))
end


-- refactoring.nvim (Overriding their functions because they are not working as expected)
vim_keymap.set({ 'n', 'x' }, '<leader>ri', function() vim.cmd('Refactor inline_var') end, opts('Inline Variable'))
vim_keymap.set('n', '<leader>rb', function() vim.cmd('Refactor extract_block') end, opts('Extract Block'))
vim_keymap.set('n', '<leader>rf', function() vim.cmd('Refactor extract_block_to_file') end, opts('Extract Block To File'))
vim_keymap.set('n', '<leader>rF', function() vim.cmd('Refactor inline_func') end, opts('Inline Function'))
vim_keymap.set('x', '<leader>rf', function() vim.cmd('Refactor extract_function') end, opts('Extract Function'))
vim_keymap.set('x', '<leader>rF', function() vim.cmd('Refactor extract_function_to_file') end, opts('Extract Function To File'))
vim_keymap.set('x', '<leader>rx', function() vim.cmd('Refactor extract_var') end, opts('Extract Variable'))


-- treesj
do
  local treesj = require('treesj')

  vim_keymap.set('n', '<leader>i', treesj.split, opts('Split code block'))
  vim_keymap.set('n', '<leader>j', treesj.join, opts('Join code block'))
end


-- Swap between fileformats
do
  local function swap_fileformats()
    local bufnr = vim.api.nvim_get_current_buf()

    if vim.bo[bufnr].fileformat == 'unix' then
      vim.bo[bufnr].fileformat = 'dos'
    elseif vim.bo[bufnr].fileformat == 'dos' then
      vim.bo[bufnr].fileformat = 'mac'
    elseif vim.bo[bufnr].fileformat == 'mac' then
      vim.bo[bufnr].fileformat = 'unix'
    end
  end

  vim_keymap.set('n', '<leader>fq', swap_fileformats, opts('Swap fileformats (unix, dos, mac)'))
end


-- Telescope
vim_keymap.set('n', '<leader>se', function() vim.cmd('Telescope symbols') end, opts('Telescope symbols'))
vim_keymap.set('n', '<leader>U', function() vim.cmd('Telescope undo') end, opts('Telescope undo'))
vim_keymap.set({ 'n', 'v', 'x' }, '"', function() vim.cmd('Telescope registers') end, opts('Telescope registers'))
vim_keymap.set({ 'n', 'v', 'x' }, '"', function() vim.cmd('Telescope marks') end, opts('Telescope marks'))
vim_keymap.set({ 'n', 'v' }, "<leader>'", function() vim.cmd('Telescope keymaps') end, opts('Telescope keymaps'))


-- bufferline
do
  local b_line = require('bufferline')

  local function b_line_sort_by_ext()
    b_line.sort_by('extension')
  end

  local function b_line_sort_by_dir()
    b_line.sort_by('directory')
  end

  local function b_line_sort_by_rel_dir()
    b_line.sort_by('relative_directory')
  end

  local function b_line_sort_by_tabs()
    b_line.sort_by('tabs')
  end

  vim_keymap.set('n', '<leader>bf', b_line.pick, opts('Bufferline Pick'))
  vim_keymap.set('n', '<leader>bF', b_line.close_with_pick, opts('Bufferline Close with Pick'))
  vim_keymap.set('n', '<leader>bL', function() vim.cmd('BufferLineMovePrev') end, opts('Bufferline Move previous'))
  vim_keymap.set('n', '<leader>bH', function() vim.cmd('BufferLineMoveNext') end, opts('Bufferline Move next'))
  vim_keymap.set('n', '<leader>bqe', b_line_sort_by_ext, opts('Bufferline Sort by Extension'))
  vim_keymap.set('n', '<leader>bqd', b_line_sort_by_dir, opts('Bufferline Sort by Directory'))
  vim_keymap.set('n', '<leader>bqr', b_line_sort_by_rel_dir, opts('Bufferline Sort by Relative Directory'))
  vim_keymap.set('n', '<leader>bqt', b_line_sort_by_tabs, opts('Bufferline Sort by Tabs'))
end


-- multicursors
do
  local mc = require('multicursors')

  vim_keymap.set({ 'n', 'v' }, '<leader>m', mc.start, opts('Create a selection for selected text or word under the cursor'))
end


-- trim.nvim
vim_keymap.set('n', '<leader>T', function() vim.cmd('Trim') end, opts('Trim all trailing whitespaces and lines'))
