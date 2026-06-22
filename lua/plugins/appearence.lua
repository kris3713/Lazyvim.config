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
  {
    'mcauley-penney/visual-whitespace.nvim',
    opts = {
      list_chars = {
        tab = '│',
      },
    },
    event = 'ModeChanged *:[vV\22]',
  },
  {
    'xzbdmw/colorful-menu.nvim', ---@module 'colorful-menu'
    ---@type ColorfulMenuConfig
    opts = {
      max_width = 60,
    },
  },
  {
    'DaikyXendo/nvim-material-icon',
    opts = {
      color_icons = true,
      default = true,
    },
  },
}
