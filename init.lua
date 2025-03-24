-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- LSP configs
-- MOST IMPORTANT (for Neovim)
require('lspconfig').lua_ls.setup {}

-- Dprint
require('lspconfig').dprint.setup {}

-- For Ruby development
require('lspconfig').solargraph.setup {}
-- require('lspconfig').ruby_ls.setup {}
require('lspconfig').sorbet.setup {}
require('lspconfig').rubocop.setup {}

-- TypeScript/JavaScript
require('lspconfig').eslint.setup {}
-- require('lspconfig').ts_ls.setup {}
require('lspconfig').vtsls.setup {}

-- CSS
require('lspconfig').css_variables.setup {}
require('lspconfig').cssmodules_ls.setup {}
require('lspconfig').tailwindcss.setup {}

-- GitHub Actions
require('lspconfig').gh_actions_ls.setup{}

-- .NET development
require'lspconfig'.csharp_ls.setup {}
require('lspconfig').msbuild_project_tools_server.setup {
  cmd = {
    'dotnet',
    os.getenv('MSBUILD_LSP') .. '/MSBuildProjectTools.LanguageServer.Host.dll'
  }
}

-- Spelling and Grammar checking
require('lspconfig').harper_ls.setup {
  settings = {
    ['harper-ls'] = {
      userDictPath = '~/MEGA/harperdict.txt',
      fileDictPath = '~/MEGA/harperdict.txt'
    }
  }
}

-- Nushell
require('lspconfig').nushell.setup {}

-- FISH
require('lspconfig').fish_lsp.setup {}

-- YAML
require('lspconfig').yamlls.setup {}

-- -- JSON
-- require('lspconfig').jsonls.setup {}

-- none-ls.nvim
local null_ls = require('null-ls')
local none_ls_diag = require('none-ls.diagnostics.eslint')

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.ts_node_action,
    null_ls.builtins.code_actions.statix,
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.prettier,
    none_ls_diag
  }
})

-- rainbow-delimiters
-- This module contains a number of default definitions
---@diagnostic disable-next-line: undefined-doc-name
---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
  highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterBlue',
    'RainbowDelimiterCyan',
    'RainbowDelimiterViolet'
  }
}
-- Change the colour of 'RainbowDelimiterGreen'
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#40a02b' })

-- indent-blankline
local highlight = {
  'RainbowRed',
  'RainbowYellow',
  'RainbowOrange',
  'RainbowGreen',
  'RainbowBlue',
  'RainbowCyan',
  'RainbowViolet'
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme chanColorSchemeges
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#ed8796' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#eed49f' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#f5a97f' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#40a02b' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#8aadf4' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c6a0f6' })
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
  trim_on_write = false,
  -- highlight trailing spaces
  highlight = true
}

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

-- noice.nvim
require('noice').setup { lsp = { hover = { silent = true }}}

-- which-key.nvim
local wk = require('which-key')

-- auto-session.nvim
wk.add {
  {
    '<leader>S',
    group = 'auto-session',
    remap = true
  }
}

-- nvim-snippets
require('snippets').setup {
  search_paths = {
    '~/MEGA/'
  }
}

require('neoscroll').setup {
  hide_cursor = false
}
