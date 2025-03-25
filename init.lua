-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- LSP configs
local lspconfig = require('lspconfig')

-- For Ruby development
lspconfig.solargraph.setup {}
-- lspconfig.ruby_ls.setup {}
-- lspconfig.sorbet.setup {}
lspconfig.rubocop.setup {}

-- TypeScript/JavaScript
lspconfig.eslint.setup {}

-- CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.css_variables.setup {}
lspconfig.cssmodules_ls.setup {}
lspconfig.cssls.setup {
  capabilities = capabilities
}

-- GitHub Actions
lspconfig.gh_actions_ls.setup{}

-- .NET development
lspconfig.csharp_ls.setup {}

local msbuild = os.getenv('MSBUILD_LSP')
if (msbuild ~= '' and msbuild ~= nil) then
  lspconfig.msbuild_project_tools_server.setup {
    cmd = {
      'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll'
    }
  }
end

-- Spelling and Grammar checking
lspconfig.harper_ls.setup {
  settings = {
    ['harper-ls'] = {
      userDictPath = '~/MEGA/harperdict.txt',
      fileDictPath = '~/MEGA/harperdict.txt'
    }
  }
}

-- Containers
lspconfig.dockerls.setup {}
lspconfig.docker_compose_language_service.setup {}

-- Nushell
lspconfig.nushell.setup {}

-- FISH
lspconfig.fish_lsp.setup {}

--- none-ls.nvim
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    -- Only add sources that are not natively
    -- supported by built-in lsp.
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.ts_node_action,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.diagnostics.markdownlint_cli2,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.fish_indent,
    -- null_ls.builtins.formatting.nixfmt,
    -- null_ls.builtins.formatting.nix_flake_fmt,
    null_ls.builtins.formatting.pg_format,
    null_ls.builtins.formatting.prettier.with {
      disabled_filetypes = {
        'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml'
      }
    },
    null_ls.builtins.formatting.rubocop,
    -- null_ls.builtins.formatting.rubyfmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.hover.dictionary
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
-- every time the colorscheme changes
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
    'ruby', 'lua', 'fish', 'sh', 'bash', 'csharp'
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

--- which-key.nvim
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

-- lualine.nvim
local function line_ending()
  local fileformat = vim.bo.fileformat
  if fileformat == 'unix' then
    return 'LF'
  elseif fileformat == 'dos' then
    return 'CRLF'
  elseif fileformat == 'mac' then
    return 'CR'
  else
    return fileformat
  end
end

local fileformat = function()
  return line_ending()
end

require('lualine').setup {
  sections = {
    lualine_x = { 'encoding', fileformat, 'filetype' },
    lualine_y = { 'selectioncount', 'progress' },
    lualine_z = { 'location' }
  }
}
