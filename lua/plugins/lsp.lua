---@diagnostic disable: missing-fields, type-not-found, assign-type-mismatch, generic-constraint-mismatch, param-type-mismatch

---Enable either lua_ls or emmylua_ls
---@param lsp_name 'lua_ls' | 'emmylua_ls'
---@return boolean
local function enable_lua_ls(lsp_name)
  local script_dir = vim.fn.expand('<sfile>:p:h')
  local filepath = script_dir .. '/.neoconf.json'
  local file = io.open(filepath, 'r')

  local json_content = nil
  if file then
    json_content = file:read('*a')
    file:close()
  else
    print('Failed to open file!')
    print(filepath)
    return false
  end

  ---@alias is_enabled { enabled: boolean }

  ---@class NeoConf_Json
  ---@private
  ---@field neoconf { plugins: {
  ---   lua_ls: is_enabled,
  ---   emmylua_ls: is_enabled
  --- }}

  local neoconf_json = nil
  local success, data = pcall(vim.json.decode, json_content, { object = true })
  if success then
    ---@cast neoconf_json NeoConf_Json?
    neoconf_json = data
  end

  if neoconf_json then
    local neoconf_plugins = neoconf_json.neoconf.plugins
    if neoconf_plugins[lsp_name] then
      ---@type is_enabled
      local name = neoconf_plugins[lsp_name]
      return name.enabled
    end
  end

  return false
end

-- MSBuild
-- local msbuild = os.getenv('MSBUILD_LSP')
-- harper dictionary path
local harperDictPath = os.getenv('HOME') .. '/MEGA/harperdict.txt'

-- Adds important capabilities to the LSP client
local function capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  ---@diagnostic disable-next-line: need-check-nil
  client_capabilities.textDocument.completion.completionItem.snippetSupport = true
  return client_capabilities
end

-- ---Opens the hover window
-- local function hover_open()
--   -- hover.nvim
--   local hover = require('hover')
--   hover.open {}
-- end

---Selects a code action available at the current cursor position.
local function ap__code_actions()
  -- actions-preview
  local ap = require('actions-preview')
  ap.code_actions {}
end

local function live_rename__rename()
  local live_rename = require('live-rename')
  live_rename.rename {}
end


return --[[@type LazyPluginSpec]]{
  'neovim/nvim-lspconfig',
  ---@param opts lspConfigOpts
  opts = function(_, opts)
    ---@type lspConfigOpts
    local lspConfig = {
      diagnostics = { virtual_text = false },
      inlay_hints = { enabled = false },
      servers = {
        ghostty_ls = {
          enabled = (function()
            local bufnr = vim.api.nvim_get_current_buf()
            local fname = vim.api.nvim_buf_get_name(bufnr)
            local ghostty_config_dir = os.getenv('HOME') .. '/.config/ghostty/'
            return vim.startswith(fname, ghostty_config_dir)
          end)(),
          cmd = { 'ghostty-ls' },
          filetypes = { 'conf' },
          ---@param on_dir any|fun(...: any): any
          root_dir = function(_, on_dir) -- harper:ignore
            -- If enabled is true, we know the file is in the desired directory.
            -- So, the root directory is simply ~/.config/ghostty.
            on_dir(os.getenv('HOME') .. '/.config/ghostty')
          end
        },
        systemd_lsp = {
          mason = false,
          enabled = true,
          ---@param bufnr integer
          ---@param on_dir any|fun(...: any): any
          root_dir = function(bufnr, on_dir)
            local fname = vim.api.nvim_buf_get_name(bufnr)

            local systemd_unit_filetypes = { -- Credit to @magnuslarsen
              -- systemd unit files
              '*.service',
              '*.socket',
              '*.timer',
              '*.mount',
              '*.automount',
              '*.swap',
              '*.target',
              '*.path',
              '*.slice',
              '*.scope',
              '*.device',
              -- Podman Quadlet files
              '*.container',
              '*.volume',
              '*.network',
              '*.kube',
              '*.pod',
              '*.build',
              '*.image'
            }

            local util = require('lspconfig.util')

            on_dir((util.root_pattern(systemd_unit_filetypes))(fname))
          end
        },
        -- clangd
        clangd = {
          mason = false,
          enabled = true
        },
        -- steep
        steep = {
          mason = false,
          enabled = true
        },
        -- sorbet
        sorbet = {
          mason = false,
          enabled = true
        },
        -- ruby-lsp
        ruby_lsp = {
          mason = false,
          enabled = true
        },
        herb_ls = {
          mason = false,
          enabled = true
        },
        -- typeprof
        typeprof = {
          enabled = true
        },
        -- lemminx
        lemminx = {
          enabled = true
        },
        -- phan
        phan = {
          mason = false,
          enabled = true
        },
        -- astro
        astro = {
          mason = false,
          enabled = true,
        },
        -- dartls
        dartls = {
          mason = false,
          enabled = true
        },
        -- gradle_ls
        gradle_ls = {
          enabled = true
        },
        -- jdtls
        jdtls = {
          enabled = true
        },
        -- kotlin_lsp
        kotlin_lsp = {
          mason = false,
          enabled = true
        },
        -- rpmspec
        rpmspec = {
          mason = false,
          enabled = true
        },
        -- tombi
        tombi = {
          mason = false,
          enabled = true
        },
        -- hadolint
        hadolint = {
          mason = false,
          enabled = false
        },
        -- fish_lsp
        fish_lsp = {
          mason = false,
          enabled = true
        },
        -- bashls
        bashls = {
          mason = false,
          enabled = true
        },
        -- biome
        biome = {
          mason = false,
          enabled = true
        },
        -- css_variables
        css_variables = {
          mason = false,
          enabled = true
        },
        -- dockerls
        dockerls = {
          mason = false,
          enabled = true
        },
        -- docker_compose_language_service
        docker_compose_language_service = {
          mason = false,
          enabled = true
        },
        -- docker_language_server
        docker_language_server = {
          mason = false,
          enabled = false
        },
        -- dprint
        dprint = {
          mason = false,
          enabled = false
        },
        -- eslint
        eslint = {
          mason = false,
          enabled = true
        },
        -- basedpyright
        basedpyright = { -- medium speed and perfect
          mason = false,
          enabled = true
        },
        -- jedi_language_server
        jedi_language_server = { -- slow, but perfect
          mason = false,
          enabled = false
        },
        -- pyrefly
        pyrefly = { -- fast and perfect
          mason = false,
          enabled = false
        },
        ty = { -- Still in beta, but has most of the expected features from a python language server
          mason = false,
          enabled = false
        },
        zuban = { -- Supports most features, but needs more.
          mason = false,
          enabled = false
        },
        -- tailwindcss
        tailwindcss = {
          mason = false,
          enabled = true
        },
        -- vimls
        vimls = {
          mason = false,
          enabled = true
        },
        -- intelephense
        intelephense = {
          mason = false,
          enabled = true
        },
        -- nil_ls
        nil_ls = {
          enabled = true,
          mason = false
        },
        -- MSBuild
        -- msbuild_project_tools_server = {
        --   enabled = msbuild ~= nil and msbuild ~= '',
        --   cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
        -- },
        -- cssls
        cssls = {
          mason = false,
          enabled = true,
          capabilities = capabilities()
        },
        -- powershell_es
        powershell_es = {
          mason = false,
          enabled = true,
          cmd = { 'powershell-editor-services' },
          settings = {
            bundle_path = (vim.fn.system {
              'nix', 'eval',
              'nixpkgs#powershell-editor-services.outPath',
              '--raw'
            } .. 'lib/powershell-editor-services/PowerShellEditorServices')
          }
        },
        -- html
        html = {
          mason = false,
          enabled = false,
          capabilities = capabilities()
        },
        -- superhtml
        superhtml = {
          mason = false,
          enabled = true
        },
        -- svelte
        svelte = {
          mason = false,
          enabled = true,
          keys = {
            {
              '<leader>co',
              vim.lsp.buf.code_action {
                apply = true,
                context = {
                  only = { 'source.organizeImports' },
                  diagnostics = {}
                }
              },
              desc = 'Organize Imports'
            }
          }
        },
        -- cssmodules_ls
        cssmodules_ls = {
          enabled = true,
          mason = false,
          filetypes = (function()
            local filetypes = require('lspconfig.configs.cssmodules_ls').default_config.filetypes
            local new_filetypes = {
              'astro',
              'vue',
              'svelte'
            }

            filetypes = vim.list_extend(filetypes, new_filetypes)
            table.sort(filetypes)

            return filetypes
          end)()
        },
        -- jsonls
        jsonls = {
          enabled = true,
          mason = false,
          capabilities = capabilities(),
          -- lazy-load schemaStore when needed
          before_init = function(_, new_config)
            local schemas = require("schemastore").json.schemas()

            if new_config.settings then
              ---@cast new_config.settings.json lsp.LSPObject
              new_config.settings.json.schemas = vim.list_extend(
                new_config.settings.json.schemas or {}, schemas)
            end
          end,
          settings = {
            json = {
              format = { enable = true },
              validate = { enable = true }
            }
          }
        },
        -- yamlls
        yamlls = {
          mason = false,
          enabled = true,
          filetypes = { 'yaml', 'yaml.gitlab', 'yaml.helm-values' },
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true
              }
            }
          },
          -- lazy-load schemastore when needed
          before_init = function(_, new_config)
            local schemas = require("schemastore").yaml.schemas()

            if new_config.settings then
              ---@cast new_config.settings.yaml lsp.LSPObject
              new_config.settings.yaml.schemas = vim.tbl_deep_extend('force',
                new_config.settings.yaml.schemas or {}, schemas)
            end
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = ''
              }
            }
          }
        },
        -- emmylua_ls
        emmylua_ls = {
          enabled = enable_lua_ls('emmylua_ls'),
          mason = false,
          root_markers = {
            '.luarc.json',
            '.luarc.jsonc',
            '.stylua.toml',
            'stylua.toml',
            'selene.toml',
            'selene.yml',
            '.emmyrc.json',
            '.git'
          },
          ---@param client vim.lsp.Client
          on_init = function(client, _)
            local uv = vim.uv

            if client.workspace_folders and client.workspace_folders[1] then
              local path = client.workspace_folders[1].name
              --- @diagnostic disable: undefined-field
              local exists = (uv.fs_stat(path .. '/.luarc.json') or
                uv.fs_stat(path .. '/.luarc.jsonc'))
              if path ~= vim.fn.stdpath('config') and exists then
                return
              end
              --- @diagnostic enable: undefined-field
            end

            if client.config.settings then
              ---@cast client.config.settings.Lua lsp.LSPObject
              client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua or {}, {
                -- Make the server aware of Neovim runtime files
                workspace = {
                  library = {
                    '${3rd}/luv/library',
                    '${3rd}/busted/library'
                  }
                  -- Or pull in all of 'runtimepath'.
                  -- NOTE: this is a lot slower and will cause issues when working on
                  -- your own configuration.
                  -- See https://github.com/neovim/nvim-lspconfig/issues/3189
                  -- library = {
                  --   vim.api.nvim_get_runtime_file('', true),
                  -- }
                }
              } --[[@as lsp.LSPObject]])
            end
          end,
          settings = {
            Lua = {
              completion = {
                callSnippet = true
              },
              runtime = {
                version = 'LuaJIT', -- Needed because Neovim is using LuaJIT as it's Lua interpreter
                requirePattern = {
                  '?.lua',
                  '?/init.lua',
                  'lua/init.lua',
                  'lua/?.lua',
                  'lua/?/init.lua',
                  'lua/?/?.lua',
                  'plugin/?.lua',
                  'ftplugin/?.lua',
                  'after/?.lua',
                  'after/?/?.lua',
                  'spec/?.lua'
                },
                frameworkVersions = { 'luv' } -- Also needed because Neovim is using luv in addition to LuaJIT
              },
              diagnostics = {
                -- This prevents diagnostics from mistaking the global variable `vim` as an unknown
                globals = {
                  'vim',
                  'LazyVim',
                  'Snacks'
                },
                disable = {
                  'unnecessary-if'
                },
                enables = {
                  'iter-variable-reassign',
                  'non-literal-expressions-in-assert',
                  'incomplete-signature-doc'
                }
              },
              codeAction = {
                insertSpace = true
              },
              strict = {
                typeCall = true,
                arrayIndex = true,
                requirePath = false
              }
            }
          }
        },
        -- lua_ls
        lua_ls = {
          enabled = enable_lua_ls('lua_ls'),
          mason = false,
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
        },
        -- Harper
        harper_ls = {
          mason = false,
          enabled = true,
          filetypes = (function()
            local filetypes = require('lspconfig.configs.harper_ls').default_config.filetypes
            local new_filetypes = {
              'astro',
              'vue',
              'svelte',
              'tex',
              'bib',
              'fish',
              'bash',
              'zsh',
              'sh'
            }

            filetypes = vim.list_extend(filetypes, new_filetypes)
            table.sort(filetypes)

            return filetypes
          end)(),
          settings = {
            ['harper-ls'] = {
              userDictPath = harperDictPath,
              fileDictPath = harperDictPath
            }
          },
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = false
                }
              }
            }
          }
        },
        -- marksman
        marksman = {
          mason = false,
          enabled = true,
          ---@param bufnr integer
          on_attach = function(_, bufnr)
            local is_md = vim.bo[bufnr].filetype == 'markdown'
            local is_mdx = vim.bo[bufnr].filetype == 'markdown.mdx'
            local is_modifiable = vim.bo[bufnr].modifiable

            if not is_modifiable and not (is_md or is_mdx) then
              return
            end
          end
        },
        -- vtsls
        vtsls = {
          mason = false,
          enabled = true,
          filetypes = (function()
            local filetypes = require('lspconfig.configs.vtsls').default_config.filetypes

            table.insert(filetypes, 'vue')
            table.sort(filetypes)

            return filetypes
          end)(),
          ---@param client vim.lsp.Client
          ---@param _ lsp.InitializeResult
          on_init = function(client, _)
            ---@type lsp.LSPArray
            local options = {
              updateImportsOnFileMove = {
                enabled = 'always'
              },
              suggest = {
                completeFunctionCalls = true
              },
              inlayHints = {
                enumMemberValues = {
                  enabled = true
                },
                functionLikeReturnTypes = {
                  enabled = true
                },
                parameterNames = {
                  enabled = 'literals'
                },
                parameterTypes = {
                  enabled = true
                },
                propertyDeclarationTypes = {
                  enabled = true
                },
                variableTypes = {
                  enabled = false
                }
              },
              preferences = {
                quoteStyle = 'single',
                importModuleSpecifier = 'shortest',
                renameMatchingJsxTags = true,
                jsxAttributeCompletionStyle = 'auto'
              }
            }

            client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, {
              typescript = options,
              javascript = options
            } --[[@as lsp.LSPObject]])
          end,
          settings = {
            complete_function_calls = true,
            experimental = { enableProjectDiagnostics = true },
            vtsls = {
              tsserver = {
                globalPlugins = {
                  {
                    name = '@astrojs/ts-plugin',
                    location = vim.fn.system {
                      'sh', '-c',
                      'pnpm list -g --json --long @astrojs/ts-plugin | '
                      .. "jq '.[0].dependencies.\"@astrojs/ts-plugin\".path' -r"
                    },
                    enableForWorkspaceTypeScriptVersions = true
                  },
                  {
                    name = '@vue/typescript-plugin',
                    location = vim.fn.system {
                      'sh', '-c',
                      'pnpm list -g --json --long @vue/typescript-plugin | '
                      .. "jq '.[0].dependencies.\"@vue/typescript-plugin\".path' -r"
                    },
                    languages = { 'vue' },
                    configNamespace = 'typescript',
                    enableForWorkspaceTypeScriptVersions = true
                  },
                  {
                    name = 'typescript-svelte-plugin',
                    location = vim.fn.system {
                      'sh', '-c',
                      'pnpm list -g --json --long typescript-svelte-plugin | '
                      .. "jq '.[0].dependencies.\"typescript-svelte-plugin\".path' -r"
                    },
                    enableForWorkspaceTypeScriptVersions = true
                  }
                }
              },
            }
          }
        },
        -- gopls
        gopls = {
          mason = false,
          enabled = true,
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
              directoryFilters = {
                '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules'
              },
              semanticTokens = true
            }
          }
        },

        -- Disabled

        -- This is taken cared of by null-ls

        -- golangci_lint_ls
        golangci_lint_ls = {
          enabled = false
        },
        -- ruff
        ruff = {
          enabled = false
        },
        -- rubocop
        rubocop = {
          enabled = false
        },
        -- texlab
        texlab = {
          enabled = false
        },
        -- statix
        statix = {
          enabled = false
        },
        -- stylua
        stylua = {
          enabled = false
        },
        -- stylelint_lsp
        stylelint_lsp = {
          enabled = false
        },
        -- gh_actions_ls
        gh_actions_ls = {
          enabled = false
        },
      },
      setup = {
        gopls = function(_, _)
          -- workaround for gopls not supporting semanticTokensProvider
          -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
          Snacks.util.lsp.on({ name = 'gopls' }, function(_, client)
            --- @diagnostic disable-next-line: need-check-nil
            if not client.server_capabilities.semanticTokensProvider then
              --- @diagnostic disable-next-line: need-check-nil
              local semantic = client.config.capabilities.textDocument.semanticTokens
              if semantic then
                --- @diagnostic disable-next-line: need-check-nil
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semantic.tokenTypes,
                    tokenModifiers = semantic.tokenModifiers
                  },
                  range = true
                }
              end
            end
          end)
          -- end workaround
        end
      }
    }

    opts.diagnostics = vim.tbl_deep_extend('force', opts.diagnostics or {}, lspConfig.diagnostics)
    opts.inlay_hints = vim.tbl_deep_extend('force', opts.inlay_hints or {}, lspConfig.inlay_hints)
    opts.servers = vim.tbl_deep_extend('force', opts.servers or {}, lspConfig.servers)
    opts.setup = vim.tbl_deep_extend('force', opts.setup or {}, lspConfig.setup)

    ---keymaps for all LSP servers/clients
    ---@type vim.api.keyset.keymap[]
    local all_keymaps = {
      { -- Hover Doc
        'K',
        function() vim.cmd('Lspsaga hover_doc') end,
        desc = 'Hover Doc',
        noremap = true
      },
      { -- Code Actions
        '<leader>ca',
        ap__code_actions,
        desc = 'Open Code Actions',
        noremap = true
      },
      { -- LSP Rename
        '<leader>cr',
        live_rename__rename,
        desc = 'Lsp Rename',
        noremap = true
      },
      { -- Line Diagnostics
        '<leader>cd',
        function() vim.cmd('Lspsaga show_line_diagnostics') end,
        desc = 'Line Diagnostics',
        noremap = true
      }
    }

    -- Special config for '*'
    if opts.servers['*'] then
      ---@cast opts.servers table<string, (lspClientOpts|vim.lsp.Client)>
      opts.servers['*'].keys = vim.list_extend(opts.servers['*'].keys or {}, all_keymaps)
    end
  end
}
