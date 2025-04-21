-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- LSP configs
local lspconfig = require('lspconfig')

-- Lua
---@type lspconfig.options.lua_ls
local lua_ls__setup = {
  settings = {
     Lua = {
        completion = {
          callSnippet = 'Replace',
          showWord = 'Enable',
          workspaceWord = true
        },
        doc = {
          privateName = { '^_' }
        },
        hint = {
          enable = true,
          setType = false,
          paramType = true,
          paramName = 'Disable',
          semicolon = 'Disable',
          arrayIndex = 'Disable'
        }
     }
  }
}

lspconfig.lua_ls.setup(lua_ls__setup)

-- Ruby
lspconfig.solargraph.setup {}

-- rpmspec
lspconfig.rpmspec.setup {
  cmd = { 'rpm_spec_language_server', '--stdio' }
}

-- CSS
local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true

---@type lspconfig.options.cssls
local cssls_setup = {
  capabilities = cssls_capabilities
}

lspconfig.css_variables.setup {}
lspconfig.cssmodules_ls.setup {}
lspconfig.cssls.setup(cssls_setup)

-- GitHub Actions
lspconfig.gh_actions_ls.setup {}

-- Markdown
lspconfig.marksman.setup {
  -- This solves the problem of Marksman exiting when a new hover doc buffer (from Lspsaga) is created
  ---@param bufnr number
  autostart = function(bufnr)
    local is_md = (vim.bo[bufnr].filetype == 'markdown') or (vim.bo[bufnr].filetype == 'markdown.mdx')
    if (vim.bo[bufnr].modifiable) and is_md then
      return true -- Return true to allow autostart
    end
    return false -- Otherwise, return false to prevent autostart
  end,
  ---@param bufnr number
  enable = function(bufnr)
    local is_md = (vim.bo[bufnr].filetype == 'markdown') or (vim.bo[bufnr].filetype == 'markdown.mdx')
    if (vim.bo[bufnr].modifiable) and is_md then
      return true -- Return true to allow autostart
    end
    return false -- Otherwise, return false to prevent autostart
  end
}

-- .NET development
local omni_ext = require('omnisharp_extended')

---@type lspconfig.options.omnisharp
local omnisharp_setup = {
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
    ['textDocument/definition'] = omni_ext.definition_handler,
    ['textDocument/typeDefinition'] = omni_ext.type_definition_handler,
    ['textDocument/references'] = omni_ext.references_handler,
    ['textDocument/implementation'] = omni_ext.implementation_handler
  }
}

lspconfig.omnisharp.setup(omnisharp_setup)

-- MSBuild
local msbuild = os.getenv('MSBUILD_LSP')
if (msbuild ~= '' and msbuild ~= nil) then
  lspconfig.msbuild_project_tools_server.setup {
    cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
  }
end

-- Typescript/Javascript (vtsls)
---@module 'lspconfig'
---@type lspconfig.options.vtsls
local vtsls_setup = {
  settings = {
    vtsls = {
      experimental = { enableProjectDiagnostics = true },
    },
    typescript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false },
      },
      preferences = {
        quoteStyle = 'single',
        importModuleSpecifier = 'shortest',
        renameMatchingJsxTags = true,
        jsxAttributeCompletionStyle = 'auto'
      }
    },
    javascript = {
      updateImportsOnFileMove = { enabled = 'always' },
      suggest = { completeFunctionCalls = true },
      inlayHints = {
        enumMemberValues = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        parameterNames = { enabled = 'literals' },
        parameterTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        variableTypes = { enabled = false }
      },
      preferences = {
        quoteStyle = 'single',
        importModuleSpecifier = 'shortest',
        renameMatchingJsxTags = true,
        jsxAttributeCompletionStyle = 'auto'
      }
    }
  }
}

lspconfig.vtsls.setup(vtsls_setup)

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
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.textlint,
    null_ls.builtins.completion.nvim_snippets,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.rpmspec,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.hover.printenv
  }
}

-- nlsp-settings.nvim
local nlspsettings = require('nlspsettings')

nlspsettings.setup({
    config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
    local_settings_dir = '.nlsp-settings',
    local_settings_root_markers_fallback = { '.git' },
    append_default_schemas = true,
    loader = 'json'
})

-- conform.nvim
-- require('conform').setup {
--   formatters_by_ft = {
--     javascript = { 'prettier', 'prettierd', stop_after_first = true },
--     typescript = { 'prettier', 'prettierd', stop_after_first = true }
--   }
-- }

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
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#ed6e6d' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#ef7734' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e2b65e' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#72d35d' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#3f78ec' })
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

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#ed6e6d' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#ef7734' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#e2b65e' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#72d35d' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3f78ec' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#7dc4e4' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c6a0f6' })

vim.g.rainbow_delimiters = { highlight = delimiter_highlight }

require('trim').setup {
  -- harper:ignore
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {
    'ruby', 'lua', 'fish', 'sh', 'bash', 'csharp'
  },
  -- harper:ignore
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
require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'diagnostics',
        on_click = function()
          require('trouble').toggle({
            mode = 'diagnostics',
            filter = { buf = vim.api.nvim_get_current_buf() }
          })
        end
      },
      {
        'lsp_status',
        on_click = function() require('snacks').picker.lsp_config() end,
      }
    },
    lualine_x = {
      { 'encoding', show_bomb = true },
      {
        name = 'fileformat',
        function()
          if vim.bo.fileformat == 'unix' then return 'LF (unix)'
          elseif vim.bo.fileformat == 'dos' then return 'CRLF (dos)'
          elseif vim.bo.fileformat == 'mac' then return 'CR (mac)'
          else return vim.bo.fileformat end
        end,
        on_click = function()
          if vim.bo.fileformat == 'unix' then vim.bo.fileformat = 'dos'
          elseif vim.bo.fileformat == 'dos' then vim.bo.fileformat = 'mac'
          elseif vim.bo.fileformat == 'mac' then vim.bo.fileformat = 'unix' end
        end
      },
      {
        'filetype',
        on_click = function ()
          require('telescope.builtin').filetypes()
        end
      }
    },
    lualine_y = { 'searchcount', 'selectioncount', 'progress' },
    lualine_z = { 'location' }
  }
}

-- telescope extensions
require('telescope').load_extension('ui-select')
require('telescope').load_extension('undo')
require('telescope').load_extension('frecency')
require('telescope').load_extension('dap')

-- nvim-cmp
local cmp = require('cmp')
local cmp_config = cmp.get_config()

---@type cmp.SourceConfig
local new_sources = {
  { name = 'nvim_lsp_signature_help' },
  { name = 'dap' },
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
vim.cmd.aunmenu('PopUp.How-to\\ disable\\ mouse')

for _, i in ipairs({'n', 'x'}) do
  -- Modified built-in entries
  vim.cmd(string.format(
    [[ %smenu PopUp.Go\ to\ definition gd ]], i
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Diagnostics <leader>cd ]], i
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]], i
  ))

  -- Implement a code actions entry
  vim.cmd(string.format(
    [[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]], i
  ))

  -- Implement all go-to definitions
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ References gr ]], i
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Implementation gI ]], i
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Type\ Definition gy ]], i
  ))
end
