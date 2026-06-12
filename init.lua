-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set catppuccin flavour
vim.g.catppuccin_flavour = 'macchiato'

-- Set the theme to Catpuccin Macchiato
vim.cmd('colorscheme catppuccin-' .. vim.g.catppuccin_flavour)

-- Enable vim loader
vim.loader.enable(true)

-- `vim.api.nvim_set_hl`
local set_hl = vim.api.nvim_set_hl

-- indent-blankline
do
  local highlight = {
    'RainbowRed',
    'RainbowOrange',
    'RainbowYellow',
    'RainbowLightGreen',
    'RainbowGreen',
    'RainbowBlue',
    'RainbowCyan',
    'RainbowViolet',
  }

  local hooks = require('ibl.hooks')
  -- Create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    set_hl(0, highlight[1], { fg = '#ed6e6d' })
    set_hl(0, highlight[2], { fg = '#ef7734' })
    set_hl(0, highlight[3], { fg = '#e2b65e' })
    set_hl(0, highlight[4], { fg = '#72d35d' })
    set_hl(0, highlight[5], { fg = '#009b00' })
    set_hl(0, highlight[6], { fg = '#3f78ec' })
    set_hl(0, highlight[7], { fg = '#7dc4e4' })
    set_hl(0, highlight[8], { fg = '#9c5aef' })
  end)

  require('ibl').setup({
    indent = {
      smart_indent_cap = true,
      char = '│',
      highlight = highlight,
      tab_char = '│',
    },
    scope = { show_start = true, show_end = true },
  })
end

-- rainbow-delimiters
do
  local highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterOrange',
    'RainbowDelimiterYellow',
    'RainbowDelimiterLightGreen',
    'RainbowDelimiterGreen',
    'RainbowDelimiterBlue',
    'RainbowDelimiterCyan',
    'RainbowDelimiterViolet',
  }

  set_hl(0, highlight[1], { fg = '#ed6e6d' })
  set_hl(0, highlight[2], { fg = '#ef7734' })
  set_hl(0, highlight[3], { fg = '#e2b65e' })
  set_hl(0, highlight[4], { fg = '#72d35d' })
  set_hl(0, highlight[5], { fg = '#009b00' })
  set_hl(0, highlight[6], { fg = '#3f78ec' })
  set_hl(0, highlight[7], { fg = '#7dc4e4' })
  set_hl(0, highlight[8], { fg = '#9c5aef' })
end

-- Keep everything else from mini.animate except the cursor animation.
do
  local mini_ani__exists, mod = pcall(require, 'mini.animate')

  if mini_ani__exists then
    mod.config.cursor.enable = false
  end
end

-- TODO: Deprecate in favor of https://github.com/meznaric/conmenu
-- mouse menu
vim.cmd('aunmenu PopUp.How-to\\ disable\\ mouse')

for _, mode in ipairs({ 'n', 'x' }) do
  -- Modified built-in entries
  vim.cmd(([[ %smenu PopUp.Go\ to\ definition gd ]]):format(mode))
  vim.cmd(([[ %smenu PopUp.Show\ Diagnostics <leader>cd ]]):format(mode))
  vim.cmd(([[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]]):format(mode))
  vim.cmd(([[ %smenu PopUp.Configure\ Diagnostics <Nop> ]]):format(mode))

  -- Implement a code actions entry
  vim.cmd(([[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]]):format(mode))

  -- Implement all go-to definitions
  vim.cmd(([[ %smenu PopUp.Show\ References gr ]]):format(mode))
  vim.cmd(([[ %smenu PopUp.Show\ Implementation gI ]]):format(mode))
  vim.cmd(([[ %smenu PopUp.Show\ Type\ Definition gy ]]):format(mode))
end

-- User commands
do
  local create_user_command = vim.api.nvim_create_user_command

  create_user_command('M', 'MurenToggle', {
    desc = 'Toggle Muren',
    bang = true,
    register = true,
    range = 0,
  })

  --- @diagnostic disable-next-line: param-type-mismatch
  create_user_command('LspInfoPicker', Snacks.picker.lsp_config, {
    desc = 'Show lsp info',
    bang = true,
    register = true,
    range = 0,
    force = true,
  })
end
