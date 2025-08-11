-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

---@param name string
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local create_autocmd = vim.api.nvim_create_autocmd

-- Get rid of Neovim's stupid cursor change
create_autocmd('VimLeave', {
  group = create_augroup('restore_cursor_shape_on_exit'),
  desc = 'Restore the cursor shape on exit of neovim',
  once = true,
  command = 'set guicursor=a:ver20'
})

-- Make sure all lsp servers close when quiting Neovim
create_autocmd('VimLeave', {
  group = create_augroup('close_all_lsp_servers_on_quit'),
  desc = 'Close all lsp servers on qutting Neovim',
  callback = function()
    vim.lsp.stop_client(vim.lsp.get_clients())
  end
})

-- Enable semantic highlighting
create_autocmd('LspTokenUpdate', {
  group = create_augroup('set_semantic_highlighting'),
  desc = 'Set semantic highlighting for LSP tokens',
  callback = function()
    vim.api.nvim_set_hl(0, '@lsp.type.class', { fg = '#eed49f' })
    vim.api.nvim_set_hl(0, '@lsp.type.typeParameter', {
      fg = '#ed9687', italic = true
    })
    -- vim.api.nvim_set_hl(0, '@lsp.type.method', { fg = '#8aadf4' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.global', { fg = '#8bd5ca' })
    vim.api.nvim_set_hl(0, '@lsp.type.event', { fg = '#72d35d' })
    vim.api.nvim_set_hl(0, '@lsp.typemod.variable.defaultLibrary', { italic = true, bold = true })
    vim.api.nvim_set_hl(0, '@lsp.typemod.parameter.readonly', { italic = true })
    vim.api.nvim_set_hl(0, '@lsp.mod.readonly', { italic = true })

    -- Golang
    vim.api.nvim_set_hl(0, '@lsp.mod.format.go', { link = '@character.printf' })
    -- vim.api.nvim_set_hl(0, '@string.escape.go', { fg = 'pink' })
  end
})

-- Auto-start for nvim-tree
create_autocmd('VimEnter', {
  group = create_augroup('autostart_nvim_tree'),
  desc = 'Auto-start nvim-tree with directory',
  once = true,
  ---@param data vim.api.create_autocmd.callback.args
  callback = function(data)
    -- Check if the `data` parameter is a table
    if type(data) ~= 'table' then return end
    -- buffer is a directory
    if not (vim.fn.isdirectory(data.file) == 1) then return end

    -- change to the directory
    vim.cmd.cd(data.file)
    -- open the tree
    require('nvim-tree.api').tree.open()
  end
})

-- nvim-tree workaround when using rmagatti/auto-session
-- create_autocmd('BufEnter', {
--   group = create_augroup('auto_session_workaround'),
--   desc = 'nvim-tree workaround for auto-session',
--   pattern = 'NvimTree*',
--   callback = function()
--     if not require('nvim-tree.explorer.view').is_visible then
--       require('nvim-tree.api').tree.open()
--     end
--   end
-- })

-- GuessIndent
create_autocmd('BufReadPost', {
  group = create_augroup('guess-indent'),
  desc = 'Activates the cmd "GuessIndent" on BufReadPost event',
  pattern = '*',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    require('guess-indent').set_from_buffer(bufnr, true, true)
  end
})
