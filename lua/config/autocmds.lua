-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name('lazyvim_wrap_spell')

---@param name string
---@return integer
local function create_augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end

local create_autocmd = vim.api.nvim_create_autocmd

local set_hl = vim.api.nvim_set_hl

-- Get rid of Neovim's stupid cursor change
create_autocmd('VimLeave', {
  group = create_augroup('restore_cursor_shape_on_exit'),
  desc = 'Restore the cursor shape on exit of neovim',
  once = true,
  command = 'set guicursor=a:ver20'
})


-- Make sure all LSP servers close when quitting Neovim
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
    set_hl(0, '@lsp.type.class', { fg = '#eed49f' })
    set_hl(0, '@lsp.type.typeParameter', { fg = '#ed9687', italic = true })
    -- set_hl(0, '@lsp.type.method', { fg = '#8aadf4' })
    set_hl(0, '@lsp.typemod.variable.global', { fg = '#8bd5ca' })
    set_hl(0, '@lsp.type.event', { fg = '#72d35d' })
    set_hl(0, '@lsp.typemod.variable.defaultLibrary', { italic = true, bold = true })
    set_hl(0, '@lsp.typemod.parameter.readonly', { italic = true })
    set_hl(0, '@lsp.mod.readonly', { italic = true })

    -- Golang
    set_hl(0, '@lsp.mod.format.go', { link = '@character.printf' })
    -- set_hl(0, '@string.escape.go', { fg = 'pink' })
  end
})


--- @diagnostic disable-next-line: assign-type-mismatch
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


-- GuessIndent
create_autocmd('BufReadPost', {
  group = create_augroup('guess_indent_activate'),
  desc = 'Activates the cmd "GuessIndent" on BufReadPost event',
  pattern = '*',
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    ---@diagnostic disable-next-line: param-type-mismatch
    require('guess-indent').set_from_buffer(bufnr, true, true)
  end
})

-- Lock a buffer to a window
create_autocmd('BufEnter', {
  group = create_augroup('lock_buffer_to_window'),
  desc = 'Pin the buffer to any window that is fixed width or height',
  callback = function(args)
    local stickybuf = require('stickybuf')

    -- local bufnr = vim.api.nvim_get_current_buf()
    local winid = vim.api.nvim_get_current_win()
    if not stickybuf.is_pinned(winid) and (vim.wo.winfixwidth or vim.wo.winfixheight) then
      stickybuf.pin(winid, {})
    end
  end
})


create_autocmd('RecordingEnter', {
  group = create_augroup('show_macro_recording_on_lualine'),
  callback = function()
    --- @diagnostic disable-next-line: missing-fields, param-type-mismatch
    require('lualine').refresh {
      place = { 'statusline' }
    }
  end
})

create_autocmd('RecordingLeave', {
  group = create_augroup('show_macro_recording_on_lualine'),
  callback = function()
    -- Small delay to allow vim.fn.reg_recording() to clear
    --- @diagnostic disable-next-line: undefined-field
    local timer = vim.uv.new_timer()
    timer:start(50, 0, vim.schedule_wrap(function()
      --- @diagnostic disable-next-line: missing-fields, param-type-mismatch
      require('lualine').refresh {
        place = { 'statusline' }
      }
    end))
  end
})
