---@module 'lazy'

return --[[@type LazyPluginSpec]] {
  'nvim-tree/nvim-tree.lua', ---@module 'nvim-tree'
  ---@param opts nvim_tree.config?
  opts = function(_, opts)
    ---@param rel_path string
    ---@return string
    local function label(rel_path)
      rel_path = rel_path:gsub(tostring(os.getenv('HOME')), '~', 1)
      -- local a = path:gsub('([a-zA-Z])[a-z0-9]+', '%1')
      -- local b = tostring(path:match '[a-zA-Z]([a-z0-9]*)$' or '')
      return rel_path
    end

    local setEnable = { enable = true }

    if not opts then
      return
    end
    -- Has potential for a more complex configuration
    opts.sync_root_with_cwd = true
    opts.respect_buf_cwd = true
    opts.update_focused_file = {
      enable = true,
      update_root = setEnable,
    }
    opts.filters = setEnable
    opts.renderer = {
      icons = {
        glyphs = {
          git = {
            unstaged = '󰄱',
            staged = '󰱒',
          },
        },
      },
      root_folder_label = label,
      group_empty = label,
    }
  end,
  dependencies = 'antosha417/nvim-lsp-file-operations',
  lazy = false,
  deactivate = function()
    vim.cmd('NvimTreeClose')
  end,
  ---@param keys LazyKeysSpec[]|LazyKeys[]
  keys = function(_, keys)
    -- Open nvim-tree at root
    local function open_at_root()
      local api = require('nvim-tree.api')
      api.tree.toggle({ path = LazyVim.root() })
    end

    -- Open nvim-tree at CWD
    local function open_at_cwd()
      local api = require('nvim-tree.api')
      api.tree.toggle({ path = vim.fn.getcwd() })
    end

    -- Change root to CWD for nvim-tree
    local function change_root_to_global_cwd()
      local api = require('nvim-tree.api')
      local global_cwd = vim.fn.getcwd(-1, -1)
      api.tree.change_root(global_cwd)
    end

    -- Focus on currently opened file in nvim-tree
    local function find_opened_file()
      local api = require('nvim-tree.api')
      api.tree.find_file({ update_root = false, open = true, focus = true })
    end

    keys = {
      {
        '<leader>e',
        open_at_root,
        desc = 'nvim-tree: Explorer nvim-tree (root)',
        mode = 'n',
      },
      {
        '<leader>E',
        open_at_cwd,
        desc = 'nvim-tree: Explorer nvim-tree (cwd)',
        mode = 'n',
      },
      {
        '<leader>fe',
        open_at_root,
        desc = 'nvim-tree: Explorer nvim-tree (root)',
        mode = 'n',
      },
      {
        '<leader>fE',
        open_at_cwd,
        desc = 'nvim-tree: Explorer nvim-tree (cwd)',
        mode = 'n',
      },
      {
        '<leader>fC',
        change_root_to_global_cwd,
        desc = 'nvim-tree: Change root to global cwd (nvim-tree)',
        mode = 'n',
      },
      {
        '<leader>fd',
        find_opened_file,
        desc = 'nvim-tree: Focus on currently opened file',
        mode = 'n',
      },
    }

    return keys
  end,
}
