-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- LSP configs
-- astro
vim.lsp.enable('astro')

-- Lua
vim.lsp.config('lua_ls', {
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
})
vim.lsp.enable('lua_ls')

-- Ruby
vim.lsp.enable('solargraph')
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('rubocop')

-- Python
-- vim.lsp.enable('pyright')
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

-- Golang
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      gofumpt = true,
      codelenses = {
        gc_details = false,
        generate = true,
        regenerate_cgo = true,
        run_govulncheck = true,
        test = true,
        tidy = true,
        upgrade_dependency = true,
        vendor = true
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true
      },
      analyses = {
        nilness = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
      semanticTokens = true
    }
  }
})
vim.lsp.enable({ 'gopls', 'golangci_lint_ls' })

-- rpmspec
vim.lsp.enable('rpmspec')

-- CSS
local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('cssls', { capabilities = cssls_capabilities })
vim.lsp.enable({ 'cssls', 'cssmodules_ls', 'css_variables' })

-- GitHub Actions
vim.lsp.enable('gh_actions_ls')

-- Markdown
vim.lsp.config('marksman', {
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
    local is_md = (vim.bo[bufnr].filetype == 'markdown') or
    (vim.bo[bufnr].filetype == 'markdown.mdx')

    if (vim.bo[bufnr].modifiable) and is_md then
      return true -- Return true to allow autostart
    end

    return false -- Otherwise, return false to prevent autostart
  end
})
vim.lsp.enable('marksman')

-- .NET development
local omni_ext = require('omnisharp_extended')

vim.lsp.config('omnisharp', {
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
})
vim.lsp.enable('omnisharp')

-- MSBuild
local msbuild = os.getenv('MSBUILD_LSP')
if (msbuild ~= '' and msbuild ~= nil) then
  vim.lsp.config('msbuild_project_tools_server', {
    cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
  })
  vim.lsp.enable('msbuild_project_tools_server')
end

-- Typescript/Javascript (vtsls)
local vtsls = {
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

vim.lsp.config('vtsls', vtsls)
vim.lsp.enable('vtsls')

-- Spelling and Grammar checking
vim.lsp.config('harper_ls', {
  settings = {
    ['harper-ls'] = {
      userDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt',
      fileDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt'
    }
  }
})
vim.lsp.enable('harper_ls')

-- Containers
vim.lsp.enable({ 'dockerls', 'docker_compose_language_service' })

-- FISH
vim.lsp.enable('fish_lsp')

-- BASH
vim.lsp.enable('bashls')

-- XML
vim.lsp.enable('lemminx')

-- YAML
vim.lsp.config('yamlls', {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = ''
      },
      schemas = require('schemastore').yaml.schemas()
    }
  }
})
vim.lsp.enable('yamlls')

-- JSON
local jsonls_capabilities = vim.lsp.protocol.make_client_capabilities()
jsonls_capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('jsonls', {
  capabilities = jsonls_capabilities,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
      validate = { enable = true }
    }
  }
})
vim.lsp.enable('jsonls')

-- Stylelint
vim.lsp.enable('stylelint_lsp')

-- PowerShell
vim.lsp.config('powershell_es', {
  bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services'
})
vim.lsp.enable('powershell_es')

--- none-ls.nvim
local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    -- Only add sources that are not natively
    -- supported by the built-in lsp.
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.nvim_snippets,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.rpmspec,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.pydoclint,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.gofumpt.with {},
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
  indent = {
    smart_indent_cap = true,
    char = '│',
    highlight = highlight,
    tab_char = '│'
  },
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
        on_click = function(clicks, _, _)
          if clicks == 2 then
            require('trouble').toggle {
              mode = 'diagnostics',
              filter = { buf = vim.api.nvim_get_current_buf() }
            }
          end
        end
      },
      {
        'lsp_status',
        ---@param clicks number
        on_click = function(clicks, _, _)
          if clicks == 2 then require('snacks').picker.lsp_config() end
        end,
      }
    },
    lualine_x = {
      { 'encoding', show_bomb = true },
      {
        -- indent_style
        function()
          if vim.bo.expandtab then
            return 'Spaces'
          else
            return 'Tabs'
          end
        end
      },
      {
        -- shiftwidth/tabstop
        function()
          if vim.bo.expandtab then
            return ('Indent Size: ' .. vim.bo.shiftwidth)
          else
            return ('Tab Width: ' .. vim.bo.tabstop)
          end
        end,
        ---@param clicks any
        on_click = function(clicks, _, _)
          if clicks == 2 then
            require('functions.set_shiftwidth_prompt').set_shiftwidth_prompt()
          end
        end
      },
      {
        -- fileformat
        function()
          if vim.bo.fileformat == 'unix' then
            return 'LF (unix)'
          elseif vim.bo.fileformat == 'dos' then
            return 'CRLF (dos)'
          elseif vim.bo.fileformat == 'mac' then
            return 'CR (mac)'
          else
            return vim.bo.fileformat
          end
        end,
        ---@param clicks number
        on_click = function(clicks, _, _)
          if clicks == 2 then
            if vim.bo.fileformat == 'unix' then
              vim.bo.fileformat = 'dos'
            elseif vim.bo.fileformat == 'dos' then
              vim.bo.fileformat = 'mac'
            elseif vim.bo.fileformat == 'mac' then
              vim.bo.fileformat = 'unix'
            end
          end
        end
      },
      {
        'filetype',
        on_click = function(clicks, _, _)
          if clicks == 2 then require('telescope.builtin').filetypes() end
        end
      }
    },
    lualine_y = { 'searchcount', 'selectioncount', 'progress' },
    lualine_z = { 'location' }
  }
}

-- telescope extensions
local telescope = require('telescope')

telescope.load_extension('ui-select')
telescope.load_extension('undo')
telescope.load_extension('frecency')
telescope.load_extension('dap')
telescope.load_extension('scope')

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

for _, mode in ipairs({'n', 'x'}) do
  -- Modified built-in entries
  vim.cmd(string.format(
    [[ %smenu PopUp.Go\ to\ definition gd ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Diagnostics <leader>cd ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]], mode
  ))
  -- vim.cmd(string.format(
  --   [[ %sunmenu PopUp.Configure\ Diagnostics ]], mode
  -- ))

  -- Implement a code actions entry
  vim.cmd(string.format(
    [[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]], mode
  ))

  -- Implement all go-to definitions
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ References gr ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Implementation gI ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Type\ Definition gy ]], mode
  ))
end

-- User commands

vim.api.nvim_create_user_command('M', 'MurenToggle', {
  desc = 'Toggle Muren', bang = true, register = true, range = 0
})
