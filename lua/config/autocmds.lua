-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Get rid of Neovim's stupid cursor change
vim.api.nvim_create_autocmd('VimLeave', {
  group = vim.api.nvim_create_augroup('restore_cursor_shape_on_exit', { clear = true }),
  desc = 'Restore the cursor shape on exit of neovim',
  command = 'set guicursor=a:ver20'
})

-- nvim-lint
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()

    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype
    require('lint').try_lint()

    -- -- You can call `try_lint` with a linter name or a list of names to always
    -- -- run specific linters, independent of the `linters_by_ft` configuration
    -- require("lint").try_lint("cspell")
  end
})
