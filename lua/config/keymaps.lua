--- @diagnostic disable: incomplete-signature-doc
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

---Sets options for keymaps
---@param desc string
---@param silent boolean?
---@return vim.keymap.set.Opts
local function opts(desc, silent)
  silent = silent or false
  ---@type vim.keymap.set.Opts
  local set_opts = { desc = desc, silent = silent }
  return set_opts
end


-- All modes (except TERMINAL 't')
local all_modes = { 'n', 'x', 'i' }


-- `vim.keymap`
local vim_keymap = vim.keymap


--- @diagnostic disable-next-line: undefined-field
-- Neovide options
if vim.g.neovide then
  vim.g.neovide_scale_factor = 1.0

  ---@type vim.keymap.set.Opts
  local other_opts = { nowait = false, noremap = false }

  --- Set zoom function for Neovide
  ---@param delta number
  local function zoom(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end

  -- Using a font with ligatures can make the text appear confusing to some people, like myself.
  -- That is why I am using the concatenation operator (..) to make the keymaps more readable.
  vim_keymap.set(all_modes, '<C->', function() zoom(1.25) end, other_opts)
  vim_keymap.set(all_modes, '<C-=>', function() zoom(1/1.25) end, other_opts)
end


-- -- Map Ctrl-z to do nothing
-- vim_keymap.set(all_modes, '<C-z>', '<Nop>', opts('', true))


-- -- Map q to do nothing
-- vim_keymap.set({ 'n', 'x' }, 'q', '<Nop>', opts('', true))


-- -- Map alt + q to macro recording
-- vim_keymap.set({ 'n', 'x' }, 'Q', 'q', opts('Record macro'))


-- Map quit command to Ctrl-q
vim_keymap.set(
  'n',
  '<C-q>',
  function() vim.cmd('q') end,
  opts('Quit Neovim', true)
)


-- Map quit all command to Ctrl+Alt+q
vim_keymap.set(
  'n',
  '<C-A-q>',
  function() vim.cmd('qa') end,
  opts('Quit all Neovim instances', true)
)


-- Change delete keymaps to "Delete without yanking"
vim_keymap.set(
  'n',
  'd',
  '"_x',
  opts('', true)
)
vim_keymap.set(
  'n',
  '<Del>',
  '"_x',
  opts('', true)
)
vim_keymap.set(
  'x',
  'd',
  '"_x',
  opts('', true)
)
vim_keymap.set(
  'x',
  '<Del>',
  '"_x',
  opts('', true)
)


-- Make it easier to paste
vim_keymap.set(
  'i',
  '<C-v>',
  '<C-r>*',
  opts('Paste', false)
)
vim_keymap.set(
  'i',
  '<S-Insert>',
  '<C-r>*',
  opts('Paste', false)
)
vim_keymap.set(
  'n',
  '<S-Insert>',
  '"+p',
  opts('Put Text After Cursor', false)
)


-- Switch between Tabs or Spaces
do
  local function switch_indent_style()
    local bufnr = vim.api.nvim_get_current_buf()
    require('utils').switch_indent_style(bufnr)
  end

  vim_keymap.set(
    'n',
    '<leader>\\',
    switch_indent_style,
    opts('Switch between Tabs or Spaces')
  )
end


-- neogen
do
  local function neogen_generate()
    local neogen = require('neogen')
    neogen.generate {}
  end

  vim_keymap.set(
    'n',
    '<leader>N',
    neogen_generate,
    opts('Generate annotations', true)
  )
end


-- Set softwrap to Alt + Z
vim_keymap.set(
  'n',
  '<A-z>',
  function() vim.cmd('set wrap!') end,
  opts('Toggle softwrap', true)
)


-- Make it easier to open LazyExtras
vim_keymap.set(
  'n',
  '<leader>L',
  function() vim.cmd('LazyExtras') end,
  opts('Open LazyExtras')
)


-- Make it easier to open Mason
vim_keymap.set(
  'n',
  '<leader>M',
  function() vim.cmd('Mason') end,
  opts('Open Mason')
)


-- Map the backwards/inverse indent to Shift + Tab
vim_keymap.set(
  'i',
  '<S-Tab>',
  '<C-d>',
  opts('Backwards/Inverse indent (INSERT mode)')
)
-- vim_keymap.set({ 'n', 'x' }, '<S-Tab>', '<S-Tab>', opts('Backwards/Inverse indent'))


-- grug-far
do
  local function grug_with_v_selection()
    local grug = require('grug-far')
    grug.with_visual_selection {
      prefills = { paths = vim.fn.expand('%') }
    }
  end

  local function grug_open()
    local grug = require('grug-far')
    grug.open {
      prefills = {
        paths = vim.fn.expand('%'),
        flags = '--fixed-strings'
      }
    }
  end

  --TODO: Add some more keymaps for normal mode

  vim_keymap.set(
    'v',
    '<leader>s/',
    grug_with_v_selection,
    opts('Search and Replace in current file')
  )
  vim_keymap.set(
    'n',
    '<leader>sR',
    grug_open,
    opts('Search and Replace in current file')
  )
end


-- -- hover.nvim
-- do
--   local hover = require('hover')
--
--   vim_keymap.set('n', '<Tab>', hover.open, opts('Hover Doc'))
--   -- vim_keymap.set('n', '<C-p>', function() hover.switch('previous', {}) end, opts('hover.nvim (Previous source)'))
--   -- vim_keymap.set('n', '<C-n>', function() hover.switch('next', {}) end, opts('hover.nvim (Next source)'))
-- end


-- Aerial
do
  local function aerial_toggle()
    local aerial = require('aerial')
    aerial.toggle {}
  end

  vim_keymap.set('n', '<leader>O', aerial_toggle, opts('Outline'))
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

  vim_keymap.set(
    'n',
    '<leader>fq',
    swap_fileformats,
    opts('Swap fileformats (unix, dos, mac)')
  )
end


-- Telescope
vim_keymap.set(
  'n',
  '<leader>se',
  function() vim.cmd('Telescope symbols') end,
  opts('Telescope symbols')
)
vim_keymap.set(
  'n',
  '<leader>U',
  function() vim.cmd('Telescope undo') end,
  opts('Telescope undo')
)
vim_keymap.set(
  'n',
  '"',
  function() vim.cmd('Telescope registers') end,
  opts('Telescope registers')
)
vim_keymap.set(
  'n',
  "<leader>'",
  function() vim.cmd('Telescope keymaps') end,
  opts('Telescope keymaps')
)

for _, lhs in ipairs { "'", '`' } do
  vim_keymap.set(
    'n',
    lhs,
    function() vim.cmd('Telescope marks') end,
    opts('Telescope marks')
  )
end


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

  vim_keymap.set(
    'n',
    '<leader>bq',
    '',
    opts('+sort by')
  )
  vim_keymap.set(
    'n',
    '<leader>bf',
    b_line.pick,
    opts('Bufferline Pick')
  )
  vim_keymap.set(
    'n',
    '<leader>bF',
    b_line.close_with_pick,
    opts('Bufferline Close with Pick')
  )
  vim_keymap.set(
    'n',
    '<leader>bL',
    function() vim.cmd('BufferLineMovePrev') end,
    opts('Bufferline Move previous')
  )
  vim_keymap.set(
    'n',
    '<leader>bH',
    function() vim.cmd('BufferLineMoveNext') end,
    opts('Bufferline Move next')
  )
  vim_keymap.set(
    'n',
    '<leader>bqe',
    b_line_sort_by_ext,
    opts('Bufferline Sort by Extension')
  )
  vim_keymap.set(
    'n',
    '<leader>bqd',
    b_line_sort_by_dir,
    opts('Bufferline Sort by Directory')
  )
  vim_keymap.set(
    'n',
    '<leader>bqr',
    b_line_sort_by_rel_dir,
    opts('Bufferline Sort by Relative Directory')
  )
  vim_keymap.set(
    'n',
    '<leader>bqt',
    b_line_sort_by_tabs,
    opts('Bufferline Sort by Tabs')
  )
end


-- nvim-surround
do
  -- disable default keymaps for nvim-surround
  local globals = {
    'nvim_surround_no_mappings',
    'nvim_surround_no_normal_mappings',
    'nvim_surround_no_visual_mappings',
    'nvim_surround_no_insert_mappings'
  }
  for _, global in ipairs(globals) do
    vim.g[global] = true
  end

  -- Delete default (annoying) keymaps
  for _, keymap in ipairs { 'ys', 'yss', 'yS', 'ySS', 'ds', 'cs', 'cS' } do
    vim_keymap.del('n', keymap)
  end

  -- Normal mode
  vim_keymap.set(
    'n',
    'gss',
    '<Plug>(nvim-surround-normal)',
    opts('Add surrounding pair around motion')
  )
  vim_keymap.set(
    'n',
    'gsS',
    '<Plug>(nvim-surround-normal-cur)',
    opts('Add surrounding pair around current line')
  )
  vim_keymap.set(
    'n',
    'gSs',
    '<Plug>(nvim-surround-normal-line)',
    opts('Add surrounding pair around motion on new lines')
  )
  vim_keymap.set(
    'n',
    'gSS',
    '<Plug>(nvim-surround-normal-cur-line)',
    opts('Add surrounding pair around current line on new lines')
  )
  vim_keymap.set(
    'n',
    'gsc',
    '<Plug>(nvim-surround-change)',
    opts('Change surrounding pair')
  )
  vim_keymap.set(
    'n',
    'gSc',
    '<Plug>(nvim-surround-change-line)',
    opts('Change surrounding pair putting replacements on new lines')
  )

  -- Visual mode
  vim_keymap.set(
    'x',
    'gss',
    '<Plug>(nvim-surround-visual)',
    opts('Add surrounding pair around visual selection')
  )
  vim_keymap.set(
    'x',
    'gsS',
    '<Plug>(nvim-surround-visual-line)',
    opts('Add surrounding pair around visual selection on new lines')
  )

  -- Delete mode
  vim_keymap.set(
    'n',
    'gsd',
    '<Plug>(nvim-surround-delete)',
    opts('Delete surrounding pair')
  )

  -- Insert mode
  vim_keymap.set(
    'i',
    '<C-g>s',
    '<Plug>(nvim-surround-insert)',
    opts('Add surrounding pair around cursor (insert mode)')
  )
  vim_keymap.set(
    'i',
    '<C-g>S',
    '<Plug>(nvim-surround-insert-line)',
    opts('Add surrounding pair around cursor on new lines (insert mode)')
  )
end
