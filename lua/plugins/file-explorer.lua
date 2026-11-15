---@module 'lazy'

return  --[[@type LazyPluginSpec]]{
  'mikavilpas/yazi.nvim', ---@module 'yazi'
  ---@type YaziConfig
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = '<f1>',
    },
  },
  event = 'VeryLazy',
  ---@param keys LazyKeysSpec[]|LazyKeys[]
  keys = function(_, keys)
    local function open_at_current_file()
      local yz = require('yazi')
      yz.yazi(yz.config)
    end

    local function open_in_cwd()
      local yz = require('yazi')
      yz.yazi(yz.config, vim.fn.getcwd(), nil)
    end

    local function open_in_root()
      local yz = require('yazi')
      yz.yazi(yz.config, LazyVim.root(), nil)
    end

    local function resume_last_session()
      local yz = require('yazi')
      yz.toggle(yz.config)
    end

    keys = {
      {
        '<leader>E',
        open_in_root,
        desc = 'yazi.nvim: Open yazi in the root',
        mode = 'n',
      },
      {
        '<leader>e',
        open_at_current_file,
        desc = 'yazi.nvim: Open yazi at the current file',
        mode = 'n',
      },
      {
        '<leader>fE',
        open_in_root,
        desc = 'yazi.nvim: Open yazi in the root',
        mode = 'n',
      },
      {
        '<leader>fe',
        open_in_cwd,
        desc = 'yazi.nvim: Open yazi in the cwd',
        mode = 'n',
      },
      {
        '<leader>Y',
        open_at_current_file,
        desc = 'yazi.nvim: Open yazi at the current file',
        mode = 'n',
      },
      {
        '<leader>cw',
        open_in_cwd,
        desc = 'yazi.nvim: Open yazi in the cwd',
        mode = 'n',
      },
      {
        '<leader><up>',
        resume_last_session,
        desc = 'yazi.nvim: Resume the last yazi session',
        mode = 'n',
      },
    }

    return keys
  end,
}
