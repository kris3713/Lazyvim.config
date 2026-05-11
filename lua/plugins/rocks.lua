---@module 'lazy'

return --[[@type (LazyPluginSpec[])]]{
  {
    'vhyrro/luarocks.nvim',
    opts = { -- Put the names of rocks from luarocks.org here:
      rocks = {
        'magick',
        'dkjson'
      }
    },
    priority = 1001,
    enabled = false
  }
}
