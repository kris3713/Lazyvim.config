---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'romus204/tree-sitter-manager.nvim',
    opts = {
      border = 'rounded',
    },
  },
  {
    'ckolkey/ts-node-action',
    opts = {},
  },
  {
    'aaronik/treewalker.nvim',
    opts = {},
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local tw = require('treewalker')
      local modes = { 'n', 'v' }

      keys = {
        {
          '<c-k>',
          tw.move_up,
          desc = 'Treewalker Up',
          mode = modes,
        },
        {
          '<c-j>',
          tw.move_down,
          desc = 'Treewalker Down',
          mode = modes,
        },
        {
          '<c-h>',
          tw.move_out,
          desc = 'Treewalker Left',
          mode = modes,
        },
        {
          '<c-l>',
          tw.move_in,
          desc = 'Treewalker Right',
          mode = modes,
        },
        {
          '<c-s-k>',
          tw.swap_up,
          desc = 'Treewalker SwapUp',
          mode = 'n',
        },
        {
          '<c-s-j>',
          tw.swap_down,
          desc = 'Treewalker SwapDown',
          mode = 'n',
        },
        {
          '<c-s-h>',
          tw.swap_left,
          desc = 'Treewalker SwapLeft',
          mode = 'n',
        },
        {
          '<c-s-l>',
          tw.swap_right,
          desc = 'Treewalker SwapRight',
          mode = 'n',
        },
      }

      return keys
    end,
  },
  {
    'Sang-it/fluoride',
    opts = {
      window = { border = 'rounded' },
    },
  },
}
