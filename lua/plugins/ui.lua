---@diagnostic disable: missing-fields
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
  },
  {
    'dstein64/nvim-scrollview',
    opts = {
      excluded_filetypes = { 'NvimTree' },
    },
  },
  {
    'nvzone/volt',
    lazy = true,
  },
  {
    'nvzone/showkeys',
    cmd = 'ShowkeysToggle',
    opts = { position = 'bottom-center' },
  },
  {
    'nvzone/minty',
    cmd = { 'Shades', 'Heufy' },
    opts = {},
  },
  {
    'abccsss/nvim-gitstatus',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'kevinhwang91/nvim-hlslens',
    opts = {},
  },
  {
    'https://git.sr.ht/~havi/telescope-toggleterm.nvim',
    opts = {},
    event = 'TermOpen',
    dependencies = 'nvim-lua/popup.nvim',
  },
  {
    'stevearc/stickybuf.nvim',
    opts = {},
  },

  {
    '3rd/image.nvim', ---@module 'image'
    ---@type Options
    opts = {
      processor = 'magick_cli',
    },
    build = false,
  },
}
