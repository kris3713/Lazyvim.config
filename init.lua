-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')


-- Set the theme to Catpuccin Macchiato
vim.cmd('colorscheme catppuccin-macchiato')


-- Configure Neovim's diagnostics
vim.diagnostic.config {
  -- Disable Neovim's built-in virtual text for diagnostics
  virtual_text = false,
  -- Enable the functionality of lsp_lines.nvim
  virtual_lines = true
}


-- Enable vim loader
vim.loader.enable()


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
    'RainbowViolet'
  }

  local hooks = require('ibl.hooks')
  -- Create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, highlight[1], { fg = '#ed6e6d' })
    vim.api.nvim_set_hl(0, highlight[2], { fg = '#ef7734' })
    vim.api.nvim_set_hl(0, highlight[3], { fg = '#e2b65e' })
    vim.api.nvim_set_hl(0, highlight[4], { fg = '#72d35d' })
    vim.api.nvim_set_hl(0, highlight[5], { fg = '#009b00' })
    vim.api.nvim_set_hl(0, highlight[6], { fg = '#3f78ec' })
    vim.api.nvim_set_hl(0, highlight[7], { fg = '#7dc4e4' })
    vim.api.nvim_set_hl(0, highlight[8], { fg = '#9c5aef' })
  end)

  require('ibl').setup {
    indent = {
      smart_indent_cap = true,
      char = '│',
      highlight = highlight,
      tab_char = '│'
    },
    scope = { show_start = true, show_end = true }
  }
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
    'RainbowDelimiterViolet'
  }

  vim.api.nvim_set_hl(0, highlight[1], { fg = '#ed6e6d' })
  vim.api.nvim_set_hl(0, highlight[2], { fg = '#ef7734' })
  vim.api.nvim_set_hl(0, highlight[3], { fg = '#e2b65e' })
  vim.api.nvim_set_hl(0, highlight[4], { fg = '#72d35d' })
  vim.api.nvim_set_hl(0, highlight[5], { fg = '#009b00' })
  vim.api.nvim_set_hl(0, highlight[6], { fg = '#3f78ec' })
  vim.api.nvim_set_hl(0, highlight[7], { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, highlight[8], { fg = '#9c5aef' })

  vim.g.rainbow_delimiters = { highlight = highlight }
end

-- harper:ignore
-- -- nvim-snippets
-- require('snippets').setup {
--   search_paths = {  os.getenv('HOME') .. '/MEGA' }
-- }


-- Keep everything else from mini.animate except the cursor animation.
do
  local mini_ani__exists, mod = pcall(require, 'mini.animate')
  if mini_ani__exists then mod.config.cursor.enable = false end
end

-- TODO: Deprecate in favor of https://github.com/meznaric/conmenu
-- mouse menu
vim.cmd('aunmenu PopUp.How-to\\ disable\\ mouse')

for _, mode in ipairs { 'n', 'x' } do
  -- Modified built-in entries
  vim.cmd(string.format(
    [[ %smenu PopUp.Go\ to\ definition gd ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Diagnostics <leader>cd ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Configure\ Diagnostics <Nop> ]],
    mode
  ))

  -- Implement a code actions entry
  vim.cmd(string.format(
    [[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]],
    mode
  ))

  -- Implement all go-to definitions
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ References gr ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Implementation gI ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Type\ Definition gy ]],
    mode
  ))
end


-- User commands
do
  vim.api.nvim_create_user_command('M', 'MurenToggle', {
    desc = 'Toggle Muren', bang = true, register = true, range = 0
  })

  --- @diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_create_user_command('LspInfoPicker', Snacks.picker.lsp_config, {
    desc = 'Show lsp info', bang = true, register = true, range = 0, force = true
  })
end
