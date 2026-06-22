---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'hiphish/rainbow-delimiters.nvim', ---@module 'rainbow-delimiters'
    ---@type rainbow_delimiters.config
    opts = {
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterOrange',
        'RainbowDelimiterYellow',
        'RainbowDelimiterLightGreen',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
      },
    },
    main = 'rainbow-delimiters.setup',
  },
  {
    'm-demare/hlargs.nvim',
    opts = {
      color = require('catppuccin.palettes').get_palette().red,
      hl_priority = 128,
    },
  },
}
