---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'Mgenuit/nvim-dap-kotlin',
    opts = {},
  },
  {
    'leoluz/nvim-dap-go',
    opts = {},
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('debugpy-adapter', {})
    end,
    ft = 'python',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local dap_py = require('dap-python')
      keys = {
        {
          '<leader>dy',
          '',
          desc = '+Dap Python',
          mode = 'n',
        },
        {
          '<leader>dyt',
          dap_py.test_method,
          desc = 'Debug Method',
          mode = 'n',
          -- expr = true,
          ft = 'python',
        },
        {
          '<leader>dyc',
          dap_py.test_class,
          desc = 'Debug Class',
          mode = 'n',
          -- expr = true,
          ft = 'python',
        },
      }

      return keys
    end,
  },
}
