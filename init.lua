-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

-- MOST IMPORTANT (for Neovim)
require('lspconfig').lua_ls.setup {}

-- rainbow delimiters
-- This module contains a number of default definitions
---@diagnostic disable-next-line: undefined-doc-name
---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan'
  }
}
-- Change the colour of 'RainbowDelimiterGreen'
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#40a02b' })

-- indent blankline
local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowBlue',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowViolet',
  'RainbowCyan'
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#ed8796' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#eed49f' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#8aadf4' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#f5a97f' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#40a02b' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c6a0f6' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#7dc4e4' })
end)

require('ibl').setup { indent = { highlight = highlight } }

require('trim').setup {
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {
    'markdown'
  },
  -- if you want to remove multiple blank lines
  patterns = {
    [[%s/\(\n\n\)\n\+/\1/]]   -- replace multiple blank lines with a single line
  },
  -- if you want to disable trim on write by default
  trim_on_write = true,
  -- highlight trailing spaces
  highlight = true
}

-- For Ruby development
require('lspconfig').solargraph.setup {}
-- require('lspconfig').ruby_ls.setup {}
require('lspconfig').sorbet.setup {}

-- none-ls.nvim
local null_ls = require('null-ls')
local none_ls_diag = require('none-ls.diagnostics.eslint')

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.ts_node_action,
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.completion.spell,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.formatting.stylua,
    none_ls_diag
  }
})

-- Keep everything else from mini.animate except the cursor animation.
local ok, mod = pcall(require, 'mini.animate')
if ok then
  mod.config.cursor.enable = false
end

-- Custom FZF integration for project.nvim - part 1
require('project_nvim').setup({
  detection_methods = { 'pattern', 'lsp' },
  show_hidden = true -- show hidden files in telescope
})
-- Continued in ./lua/config/keymaps.lua

-- -- LuaSnip
-- require("luasnip.loaders.from_vscode").lazy_load ({
--   paths = {
--     '~/MEGA/Personal Application Settings/For VSCodium or VSCode'
--   }
-- })

-- noice.nvim
require('noice').setup { lsp = { hover = { silent = true }}}

-- which-key.nvim
local wk = require('which-key')

wk.add {
  {
    '<leader>S',
    group = 'auto-session',
    remap = true
  }
}

-- -- cspell.nvim
-- local config = {
--   -- The CSpell configuration file can take a few different names this option
--   -- lets you specify which name you would like to use when creating a new
--   -- config file from within the `Add word to cspell json file` action.
--   --
--   -- See the currently supported files in https://github.com/davidmh/cspell.nvim/blob/main/lua/cspell/helpers.lua
--   config_file_preferred_name = 'cspell.yml',
--
--   -- A list of directories that contain additional cspell.json config files or
--   -- support the creation of a new config file from a code action
--   --
--   -- looks for a cspell config in the ~/.config/ directory, or creates a file in the directory
--   -- using 'config_file_preferred_name' when a code action for one of the locations is selected
--   cspell_config_dirs = { '~/MEGA/Others/' }
-- }
--
-- local cspell = require('lspconfig.configs.openscad_ls')
-- require('null-ls').setup {
--     sources = {
--         cspell.diagnostics.with({ config = config }),
--         cspell.code_actions.with({ config = config }),
--     }
-- }
