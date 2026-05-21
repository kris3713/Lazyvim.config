---@module 'lazy'

return --[[@type (LazyPluginSpec[])]]{
  {
    'cursortab/cursortab.nvim',
    opts = {},
    build = 'cd server && go build',
    enabled = false
  }
}
