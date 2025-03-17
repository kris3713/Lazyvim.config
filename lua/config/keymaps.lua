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

-- Map c to yank command
vim.keymap.set('n', 'c', ':y<cr>', { noremap = true })
vim.keymap.set('x', 'c', ':y<cr>', { noremap = true })

-- Change delete keymaps to "Delete without yanking"
vim.keymap.set('n', 'd', '"_x', { noremap = true })
vim.keymap.set('n', '<Del>', '"_x', { noremap = true })
vim.keymap.set('x', 'd', '"_x', { noremap = true })
vim.keymap.set('x', '<Del>', '"_x', { noremap = true })

-- Make it easier to paste in INSERT mode
vim.keymap.set('i', '<C-v>', '<C-R>+')
vim.keymap.set('i', '<S-Insert>', '<C-R>+')

-- Change keymap for "Explorer Snacks" (Netrw)
vim.keymap.set('n', '<Space>e', ':Neotree<CR>', { desc = 'Open Neotree', remap = false })

-- lazygit keymaps
vim.keymap.set('n', '\\l', ':LazyGit<cr>', { desc = 'LazyGit' })
vim.keymap.set('n', '\\L', ':LazyGit<cr>', { desc = 'LazyGit' })

-- Neovim Diagnostics Float

-- Toggles Diagnostics
function Toggle_Diagnostics()
  -- If we find a floating window, close it.
  local found_float = false
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, true)
      found_float = true
    end
  end

  if found_float then return end

  vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
end

vim.keymap.set("n", "\\i", function() Toggle_Diagnostics() end, { desc = "Toggle Diagnostics" })
vim.keymap.set("n", "\\I", function() Toggle_Diagnostics() end, { desc = "Toggle Diagnostics" })

-- Neovim Code Actions
vim.keymap.set('n', '\\c', function() vim.lsp.buf.code_action() end, { buffer = true })
