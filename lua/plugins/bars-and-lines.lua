---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'Bekaboo/dropbar.nvim', ---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = {
          border = 'rounded',
        },
      },
    },
    lazy = false,
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local dropbar_api = require('dropbar.api')

      keys = {
        {
          '<leader>;',
          dropbar_api.pick,
          desc = 'Pick symbols in winbar',
          mode = 'n',
        },
        {
          '[;',
          dropbar_api.goto_context_start,
          desc = 'Go to start of current context',
          mode = 'n',
        },
        {
          '];',
          dropbar_api.select_next_context,
          desc = 'Select next context',
          mode = 'n',
        },
      }

      return keys
    end,
  }
}
