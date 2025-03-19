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
vim.keymap.set('n', '<C-q>', ':exit<cr>', {
  desc = 'Quit Neovim', noremap = true, silent = true
})

-- Change delete keymaps to "Delete without yanking"
vim.keymap.set('n', 'd', '"_x', { noremap = true })
vim.keymap.set('n', '<Del>', '"_x', { noremap = true })
vim.keymap.set('x', 'd', '"_x', { noremap = true })
vim.keymap.set('x', '<Del>', '"_x', { noremap = true })

-- Make it easier to paste in INSERT mode
vim.keymap.set('i', '<C-v>', '<C-R>+', { noremap = true })
vim.keymap.set('i', '<S-Insert>', '<C-R>+', { noremap = true })

-- -- Change keymap for Explorer Snacks
-- vim.keymap.set('n', '<Space>e', ':Neotree<CR>', {
--   desc = 'Open Neotree', noremap = true
-- })

-- lazygit keymaps
vim.keymap.set('n', 'gl', ':LazyGit<cr>', {
  desc = 'LazyGit', noremap = true
})

-- Neovim Diagnostics Float
vim.keymap.set('n', 'gi', function()
  -- If we find a floating window, close it.
  local found_float = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      vim.api.nvim_win_close(win, true)
      found_float = true
    end
  end

  if found_float then return end

  vim.diagnostic.open_float(nil, { focus = false, scope = 'cursor' })
end, { desc = 'Toggle Diagnostics', noremap = true })

-- actions-preview.nvim
vim.keymap.set({ 'v', 'n' }, 'gf', require('actions-preview').code_actions, {
  desc = 'Open Code Actions', noremap = true
})

-- Map the reverse tab character to Shift + Tab
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true })

-- -- Keymap for disabling Codeium
-- vim.keymap.set('n', '<leader>\\', '<cmd>CodeiumToggle<CR>', {
--   desc = 'Toggles Codeium on or off', noremap = true
-- })

-- nvim-spectre
local cmd_part = '<cmd>lua require("spectre")'

vim.keymap.set('n', '<leader>sS', cmd_part .. '.toggle()<CR>', {
  desc = 'Toggle Spectre'
})
vim.keymap.set('n', '<leader>sw', cmd_part .. '.open_visual({select_word=true})<CR>', {
  desc = 'Search current word'
})
vim.keymap.set('v', '<leader>sw', '<esc>' .. cmd_part .. '.open_visual()<CR>', {
  desc = 'Search current word'
})
vim.keymap.set('n', '<leader>sp', cmd_part .. '.open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file'
})

-- neogen
vim.api.nvim_set_keymap('n', '<Leader>N', ':lua require("neogen").generate()<CR>', {
  desc = 'Generate annotations',
  noremap = true, silent = true
})

-- Set softwrap to Alt + Z
vim.keymap.set('n', '<A-z>', ':set wrap!<CR>', { desc = 'Toggle softwrap.' })
