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

-- Enable semantic highlighting
vim.api.nvim_create_autocmd('LspTokenUpdate', {
  group = vim.api.nvim_create_augroup('set_semantic_highlighting', { clear = true }),
  callback = function()
    vim.api.nvim_set_hl(0, '@lsp.type.class', { fg = '#eed49f' })
    vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = '#ed8796' })
    vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', { fg = '#ed8796' })
    vim.api.nvim_set_hl(0, '@lsp.type.method', { fg = '#8aadf4' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.global', { fg = '#8bd5ca' })
    vim.api.nvim_set_hl(0, '@lsp.type.event', { fg = '#40a02b' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.defaultLibrary', {
      fg = '#f5a97f', italic = true
    })
    -- vim.api.nvim_set_hl(0, '@lsp.mod.declaration', { fg = '#f5bde6' })
    -- vim.api.nvim_set_hl(0, '@lsp.mod.global', { fg = '##', bold = true })
    vim.api.nvim_set_hl(0, '@lsp.typemod.parameter.readonly', { italic = true })
    vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { italic = true })
  end
})
