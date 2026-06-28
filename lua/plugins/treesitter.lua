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
      local modes = { 'n', 'v' }

      keys = {
        {
          '<c-k>',
          function()
            vim.cmd('Treewalker Up')
          end,
          desc = 'Treewalker Up',
          mode = modes,
        },
        {
          '<c-j>',
          function()
            vim.cmd('Treewalker Down')
          end,
          desc = 'Treewalker Down',
          mode = modes,
        },
        {
          '<c-h>',
          function()
            vim.cmd('Treewalker Left')
          end,
          desc = 'Treewalker Left',
          mode = modes,
        },
        {
          '<c-l>',
          function()
            vim.cmd('Treewalker Right')
          end,
          desc = 'Treewalker Right',
          mode = modes,
        },
        {
          '<c-s-k>',
          function()
            vim.cmd('Treewalker SwapUp')
          end,
          desc = 'Treewalker SwapUp',
          mode = 'n',
        },
        {
          '<c-s-j>',
          function()
            vim.cmd('Treewalker SwapDown')
          end,
          desc = 'Treewalker SwapDown',
          mode = 'n',
        },
        {
          '<c-s-h>',
          function()
            vim.cmd('Treewalker SwapLeft')
          end,
          desc = 'Treewalker SwapLeft',
          mode = 'n',
        },
        {
          '<c-s-l>',
          function()
            vim.cmd('Treewalker SwapRight')
          end,
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
