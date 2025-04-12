-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

---@param name string
---@return integer
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

-- Get rid of Neovim's stupid cursor change
vim.api.nvim_create_autocmd('VimLeave', {
  group = create_augroup('restore_cursor_shape_on_exit'),
  desc = 'Restore the cursor shape on exit of neovim',
  once = true,
  command = 'set guicursor=a:ver20'
})

-- Enable semantic highlighting
vim.api.nvim_create_autocmd('LspTokenUpdate', {
  group = create_augroup('set_semantic_highlighting'),
  desc = 'Set semantic highlighting for LSP tokens',
  callback = function()
    vim.api.nvim_set_hl(0, '@lsp.type.class', { fg = '#eed49f' })
    -- vim.api.nvim_set_hl(0, '@lsp.type.parameter', { fg = '#ed8796' })
    vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', {
      fg = '#ed8796', italic = true
    })
    vim.api.nvim_set_hl(0, '@lsp.type.method', { fg = '#8aadf4' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.global', { fg = '#8bd5ca' })
    vim.api.nvim_set_hl(0, '@lsp.type.event', { fg = '#40a02b' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.defaultLibrary', {
      fg = '#f5a97f', italic = true
    })
    vim.api.nvim_set_hl(0, '@lsp.typemod.parameter.readonly', { italic = true })
    vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { italic = true })
  end
})

-- Auto-start for nvim-tree
vim.api.nvim_create_autocmd('VimEnter', {
  group = create_augroup('autostart_nvim_tree'),
  desc = 'Auto-start nvim-tree with directory',
  once = true,
  ---@param data vim.api.create_autocmd.callback.args
  callback = function(data)
    -- Check if the `data` parameter is a table
    if type(data) ~= "table" then return end
    -- buffer is a directory
    if not (vim.fn.isdirectory(data.file) == 1) then return end

    -- change to the directory
    vim.cmd.cd(data.file)
    -- open the tree
    require('nvim-tree.api').tree.open()
  end
})

-- nvim-tree workaround when using rmagatti/auto-session
vim.api.nvim_create_autocmd('BufEnter', {
  group = create_augroup('auto_session'),
  desc = 'nvim-tree workaround for auto-session',
  pattern = 'NvimTree*',
  callback = function()
    if not require('nvim-tree.view').is_visible then
      require('nvim-tree.api').tree.open()
    end
  end
})

-- Enforce Unix-style line endings for all files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'WinEnter' }, {
  group = create_augroup('change_line_ending'),
  desc = 'Ensure that all files have Unix-style line endings',
  pattern = '*',
  callback = function()
    local is_true = (vim.bo.filetype ~= 'help') or
      (vim.bo.filetype ~= 'man') or
      (vim.bo.filetype ~= 'gitcommit')
    if is_true then
      vim.o.fileformat = 'unix'
      vim.o.fileformats = 'unix,dos,mac'
    end
  end
})
