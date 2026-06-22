---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'dgagn/diagflow.nvim',
    opts = {
      padding_right = 3,
      padding_top = 7,
      border_chars = {
        top_left = '╭',
        top_right = '╮',
        bottom_left = '╰',
        bottom_right = '╯',
      },
      show_borders = true,
    },
    event = 'LspAttach',
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    opts = {},
    event = 'VeryLazy',
    priority = 1000,
  },
}
