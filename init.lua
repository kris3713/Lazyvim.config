-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- LSP configs
local lspconfig = require('lspconfig')

-- For Ruby development
lspconfig.solargraph.setup {}

-- CSS
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.css_variables.setup {}
lspconfig.cssmodules_ls.setup {}
lspconfig.cssls.setup { capabilities = capabilities }

-- GitHub Actions
lspconfig.gh_actions_ls.setup {}

-- Markdown
lspconfig.marksman.setup {
  -- This solves the problem of Marksman exiting when a new hover doc buffer (from Lspsaga) is created
  autostart = function()
    local is_md = (vim.bo.filetype == 'markdown') or (vim.bo.filetype == 'markdown.mdx')
    if (vim.bo.modifiable) and is_md then
      return true -- Return true to allow autostart
    end
    return false -- Otherwise, return false to prevent autostart
  end
}

-- .NET development
local omni = require('omnisharp_extended')

lspconfig.omnisharp.setup {
  FormattingOptions = {
    -- Enables support for reading code style, naming convention and analyzer
    -- settings from `.editorconfig`
    EnableEditorConfigSupport = true,
    -- Specifies whether 'using' directives should be grouped and sorted during
    -- document formatting.
    OrganizeImports = true
  },
  MsBuild = {
    -- If true, MSBuild project system will only load projects for files that
    -- were opened in the editor. This setting is useful for big C# codebases
    -- and allows for faster initialization of code navigation features only
    -- for projects that are relevant to code that is being edited. With this
    -- setting enabled OmniSharp may load fewer projects and may thus display
    -- incomplete reference lists for symbols.
    LoadProjectsOnDemand = true
  },
  RoslynExtensionsOptions = {
    -- Enables support for roslyn analyzers, code fixes and rulesets.
    EnableAnalyzersSupport = true,
    -- Enables support for showing unimported types and unimported extension
    -- methods in completion lists. When committed, the appropriate using
    -- directive will be added at the top of the current file. This option can
    -- have a negative impact on initial completion responsiveness,
    -- particularly for the first few completion sessions after opening a
    -- solution.
    EnableImportCompletion = true,
    -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
    -- true
    AnalyzeOpenDocumentsOnly = nil
  },
  handlers = {
    ["textDocument/definition"] = omni.definition_handler,
    ["textDocument/typeDefinition"] = omni.type_definition_handler,
    ["textDocument/references"] = omni.references_handler,
    ["textDocument/implementation"] = omni.implementation_handler
  }
}

local msbuild = os.getenv('MSBUILD_LSP')
if (msbuild ~= '' and msbuild ~= nil) then
  lspconfig.msbuild_project_tools_server.setup {
    cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
  }
end

-- Spelling and Grammar checking
lspconfig.harper_ls.setup {
  settings = {
    ['harper-ls'] = {
      userDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt',
      fileDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt'
    }
  }
}

-- Containers
lspconfig.dockerls.setup {}
lspconfig.docker_compose_language_service.setup {}

-- FISH
lspconfig.fish_lsp.setup {}

-- BASH
lspconfig.bashls.setup{}

-- XML language server
lspconfig.lemminx.setup {}

-- Stylelint
lspconfig.stylelint_lsp.setup {}

--- none-ls.nvim
local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    -- Only add sources that are not natively
    -- supported by the built-in lsp.
    null_ls.builtins.code_actions.refactoring.with {
      filetypes = {}
    },
    null_ls.builtins.code_actions.textlint,
    null_ls.builtins.completion.nvim_snippets,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.hadolint,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.markdownlint_cli2,
    null_ls.builtins.diagnostics.rpmspec,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.markdownlint,
    -- null_ls.builtins.formatting.nixfmt,
    -- null_ls.builtins.formatting.nix_flake_fmt,
    null_ls.builtins.formatting.prettier.with {
      disabled_filetypes = { 'css', 'scss', 'less', 'html', 'json', 'jsonc', 'yaml' }
    },
    null_ls.builtins.formatting.rubocop,
    -- null_ls.builtins.formatting.rubyfmt,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.hover.printenv
  }
}

-- rainbow-delimiters and
-- indent-blankline
local highlight = {
  'RainbowRed',
  'RainbowOrange',
  'RainbowYellow',
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
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#f5a97f' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#eed49f' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#40a02b' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#8aadf4' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c6a0f6' })
end)

require('ibl').setup {
  indent = { highlight = highlight },
  scope = { show_start = true, show_end = true }
}

-- rainbow-delimiters
-- This module contains a number of default definitions
local delimiter_highlight = {
  'RainbowDelimiterRed',
  'RainbowDelimiterOrange',
  'RainbowDelimiterYellow',
  'RainbowDelimiterGreen',
  'RainbowDelimiterBlue',
  'RainbowDelimiterCyan',
  'RainbowDelimiterViolet'
}

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#ed8796' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#f5a97f' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#eed49f' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#40a02b' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#8aadf4' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#7dc4e4' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c6a0f6' })

vim.g.rainbow_delimiters = { highlight = delimiter_highlight }

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
local mini_ani_exists, mod = pcall(require, 'mini.animate')
if mini_ani_exists then mod.config.cursor.enable = false end

-- nvim-snippets
require('snippets').setup {
  search_paths = { vim.uv.os_homedir() .. '/MEGA' }
}

-- lualine.nvim
local function line_ending()
  if vim.bo.fileformat == 'unix' then return 'LF (unix)'
  elseif vim.bo.fileformat == 'dos' then return 'CRLF (dos)'
  elseif vim.bo.fileformat == 'mac' then return 'CR (mac)'
  else return vim.bo.fileformat end
end

local function fileformat() return line_ending() end

require('lualine').setup {
  sections = {
    lualine_c = { 'diagnostics', 'lsp_status' },
    lualine_x = { 'encoding', fileformat, 'filetype' },
    lualine_y = { 'selectioncount', 'progress' },
    lualine_z = { 'location' }
  }
}

-- telescope extensions
require('telescope').load_extension('undo')
require('telescope').load_extension('frecency')
require('telescope').load_extension('dap')

-- lspkind + nvim-cmp
local cmp = require('cmp')
local cmp_config = cmp.get_config()

---@type cmp.SourceConfig
local new_sources = {
  { name = 'nvim_lsp_signature_help' },
  { name = 'dap' },
  {
    name = 'fish',
    option = { fish_path = '/usr/bin/fish' }
  },
  { name = 'render-markdown' }
}

for _, i in ipairs(new_sources) do
  table.insert(cmp_config.sources, i)
end

---@type cmp.ConfigSchema
local cmp_setup = {
  window = {
    completion = {
      border = 'rounded'
    },
    documentation = {
      border = 'rounded'
    }
  },
  formatting = { format = require('lspkind').cmp_format {} },
  sources = cmp_config.sources
}

cmp.setup(cmp_setup)

-- mouse menu
vim.cmd.iunmenu('PopUp.How-to\\ disable\\ mouse')
vim.cmd([[
  unmenu PopUp.How-to\ disable\ mouse
  " Add diagnostics
  menu PopUp.Diagnostics <leader>cd
  " Add code actions
  menu PopUp.Code\ Actions <leader>ca
  " Implement all goto definitions
  menu PopUp.References gr
  menu PopUp.Implementation gI
  menu PopUp.Type\ Definition gy
]])
