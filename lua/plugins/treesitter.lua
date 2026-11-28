---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
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
          tw.up,
          desc = 'Treewalker Up',
          mode = modes,
        },
        {
          '<c-j>',
          tw.down,
          desc = 'Treewalker Down',
          mode = modes,
        },
        {
          '<c-h>',
          tw.left,
          desc = 'Treewalker Left',
          mode = modes,
        },
        {
          '<c-l>',
          tw.right,
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
