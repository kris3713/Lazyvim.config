-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Get rid of Neovim's stupid cursor change
local restore_cursor_augroup = vim.api
  .nvim_create_augroup('restore_cursor_shape_on_exit', { clear = true })

vim.api.nvim_create_autocmd('VimLeave',{
  group = restore_cursor_augroup,
  desc = 'Restore the cursor shape on exit of neovim',
  command = 'set guicursor=a:ver20'
})

-- Toggle visual whitespaces
vim.api.nvim_create_augroup('VisualWhitespace', { clear = true })

vim.api.nvim_create_autocmd('VimEnter', {
  group = 'VisualWhitespace',
  pattern = '*',
  callback = function()
    require('nvim-neo-tree/neo-tree.nvim').toggle()
  end,
})

-- neotree
-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
-- because `cwd` is not set up properly.
vim.api.nvim_create_autocmd('BufNewFile', {
  group    = vim.api.nvim_create_augroup('RemoteFile', {clear = true}),
  callback = function()
    local f = vim.fn.expand('%:p')
    for _, v in ipairs{'sftp', 'scp', 'ssh', 'dav', 'fetch', 'ftp', 'http', 'rcp', 'rsync'} do
      local p = v .. '://'
      if string.sub(f, 1, #p) == p then
        vim.cmd[[
          unlet g:loaded_netrw
          unlet g:loaded_netrwPlugin
          runtime! plugin/netrwPlugin.vim
          silent Explore %
        ]]
        vim.api.nvim_clear_autocmds{group = 'RemoteFile'}
        break
      end
    end
  end
})
