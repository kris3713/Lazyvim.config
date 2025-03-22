-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set zoom function for Neovide
local function change_scale_factor(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set({ 'n', 'x', 'i' }, '<C-=>', function()
  change_scale_factor(1.25)
end)
vim.keymap.set({ 'n', 'x', 'i' }, '<C-->', function()
  change_scale_factor(1/1.25)
end)

-- Map Ctrl-z to do nothing
vim.keymap.set({ 'n', 'x', 'i' }, '<C-z>', '<Nop>', {
  noremap = true, silent = true
})

-- Map q to do nothing
vim.keymap.set('n', 'q', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('x', 'q', '<Nop>', { noremap = true, silent = true })

-- Map quit command to Ctrl-q
vim.keymap.set('n', '<C-q>', ':exit<CR>', {
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
vim.keymap.set('n', '<C-v>', '"+p', { noremap = true })
vim.keymap.set('n', '<S-Insert>', '"+p', { noremap = true })

-- Neovim Diagnostics Float
vim.keymap.set({ 'x', 'n' }, 'gi', function()
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
local ap = require('actions-preview')

vim.keymap.set({ 'x', 'n' }, '<leader>xf', ap.code_actions, {
  desc = 'Open Code Actions', noremap = true
})

-- neogen
vim.keymap.set('n', '<Leader>N', ':lua require("neogen").generate()<CR>', {
  desc = 'Generate annotations', remap = true, silent = true
})

-- Set softwrap to Alt + Z
vim.keymap.set('n', '<A-z>', ':set wrap!<CR>', {
  desc = 'Toggle softwrap.', noremap = true
})

-- Make it easier to open LazyExtras
vim.keymap.set('n', '<leader>L', ':LazyExtras<CR>', { remap = true })

-- Make it easier to open Mason
vim.keymap.set('n', '<leader>M', ':Mason<CR>', { remap = true })

-- -- Custom FZF integration for project.nvim - part 2
-- local ok, fzf = pcall(require, 'fzf-lua')
-- if ok then
--   vim.keymap.set('n', '<leader>fp', function()
--     fzf.fzf_exec(function(add_to_results)
--       local contents = require('project_nvim').get_recent_projects()
--       for _, project in pairs(contents) do
--         add_to_results(project)
--       end
--       -- close the fzf named pipe, this signals EOF and terminates the fzf 'loading' indicator.
--       add_to_results()
--     end,
--     {
--       prompt = 'Projects> ',
--       actions = {
--         ['default'] = function(choice)
--           vim.cmd.edit(choice[1])
--         end,
--         ['ctrl-x'] = {
--           function(choice)
--             local history = require('project_nvim.utils.history')
--             local delete = vim.fn.confirm("Delete '' .. choice[1] .. '' projects? ", '&Yes\n&No', 2)
--             if delete == 1 then
--               history.delete_project({ value = choice[1] })
--             end
--           end,
--           fzf.actions.resume,
--         },
--       },
--     })
--   end, { silent = true, desc = 'Projects', remap = true })
-- end

-- Luasnip
-- local ls = require('luasnip')
--
-- vim.keymap.set('i', '<C-K>', function()
--   ls.expand()
-- end, { silent = true, noremap = true })
-- vim.keymap.set({ 'i', 's' }, '<C-L>', function()
--   ls.jump( 1)
-- end, { silent = true, noremap = true })
-- vim.keymap.set({ 'i', 's' }, '<C-J>', function()
--   ls.jump(-1)
-- end, { silent = true, noremap = true })
--
-- vim.keymap.set({ 'i', 's' }, '<C-E>', function()
--   if ls.choice_active() then ls.change_choice(1) end
-- end, { silent = true, noremap = true })

-- auto-session
vim.keymap.set('n', '<leader>SS', ':SessionSearch<CR>', {
  desc = 'Search Saved Sessions', noremap = true
})

vim.keymap.set('n', '<leader>Ss', ':SessionSave<CR>', {
    desc = 'Save Session', noremap = true
})

-- Map the backwards indent to Shift + Tab
vim.keymap.set({ 'i' , 's' }, '<S-Tab>', '<C-d>', { noremap = true, silent = true })
