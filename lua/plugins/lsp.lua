---@diagnostic disable-next-line: unknown-diag-code
---@diagnostic disable: missing-fields, type-not-found

-- MSBuild
local msbuild = os.getenv('MSBUILD_LSP')
-- harper dictionary path
local harperDictPath = os.getenv('HOME') .. '/MEGA/harperdict.txt'

---Adds important capabilities to the LSP client
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

-- NOTE: Switch back to this if Lspsaga hover_doc doesn't work

-- local function pretty_hover__hover()
--   local pretty_hover = require('pretty_hover')
--   pretty_hover.hover {}
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


return {
  'neovim/nvim-lspconfig',
  ---@type lspConfigOpts
  opts = {
    inlay_hints = { enabled = false },
    servers = {
      -- All servers
      ['*'] = {
        keys = {
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
          { -- Hover Doc
            'K',
            function() vim.cmd('Lspsaga hover_doc') end,
            desc = 'Hover Doc',
            noremap = true
          },
          { -- Line Diagnostics
            '<leader>cd',
            function() vim.cmd('Lspsaga show_line_diagnostics') end,
            desc = 'Line Diagnostics',
            noremap = true
          }
        }
      },
      ghostty_ls = {
        enabled = true,
        cmd = { 'ghostty-ls' },
        filetypes = { 'conf' },
        root_markers = { 'ghostty/config' }
      },
      systemd_lsp = {
        mason = false,
        enabled = true,
        ---@param bufnr integer
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
      steep = {
        mason = false,
        enabled = true
      },
      sorbet = {
        mason = false,
        enabled = true
      },
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
      astro = {
        mason = false,
        enabled = true,
      },
      -- gh_actions_ls
      gh_actions_ls = {
        mason = false,
        enabled = false
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
        enabled = false
      },
      -- jedi_language_server
      jedi_language_server = { -- slow, but perfect
        mason = false,
        enabled = false
      },
      -- pyrefly
      pyrefly = { -- fast and perfect
        mason = false,
        enabled = true
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
      msbuild_project_tools_server = {
        enabled = msbuild ~= nil and msbuild ~= '',
        cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
      },
      -- csharp_ls
      csharp_ls = {
        enabled = true,
        settings = { AutomaticWorkspaceInit = true }
      },
      -- cssls
      cssls = {
        mason = false,
        enabled = true,
        capabilities = capabilities()
      },
      -- powershell_es
      powershell_es = {
        enabled = true,
        settings = {
          bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services'
        }
      },
      -- html
      html = {
        mason = false,
        enabled = false,
        capabilities = capabilities()
      },
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
        -- lazy-load schemastore when needed
        before_init = function(_, new_config)
          --- @diagnostic disable-next-line: need-check-nil
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(
            --- @diagnostic disable-next-line: need-check-nil
            new_config.settings.json.schemas,
            require("schemastore").json.schemas()
          )
        end,
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true }
          },
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
          --- @diagnostic disable-next-line: need-check-nil, assign-type-mismatch
          new_config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            --- @diagnostic disable-next-line: need-check-nil
            --- @diagnostic disable-next-line: generic-constraint-mismatch
            new_config.settings.yaml.schemas or {},
            --- @diagnostic disable-next-line: param-type-mismatch
            require("schemastore").yaml.schemas()
          )
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
        enabled = true,
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
        ---@param _ lsp.InitializeResult
        on_init = function(client, _)
          if client.workspace_folders then
            --- @diagnostic disable-next-line: need-check-nil
            local path = client.workspace_folders[1].name
            if
              path ~= vim.fn.stdpath('config')
              --- @diagnostic disable-next-line: undefined-field
              and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
              return
            end
          end

          if client.config.settings then
            --- @diagnostic disable-next-line: param-type-mismatch, assign-type-mismatch, generic-constraint-mismatch
            client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
            })
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
            -- signature = {
            --   detailSignatureHelper = true
            -- },

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
        enabled = false,
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
      -- markdown_oxide
      markdown_oxide = {
        mason = false,
        enabled = (function()
          local bufnr = vim.api.nvim_get_current_buf()
          local is_md = vim.bo[bufnr].filetype == 'markdown'
          local is_modifiable = vim.bo[bufnr].modifiable

          if is_modifiable and is_md then
            return true -- Return true to enable
          end

          return false
        end)()
      },
      -- marksman
      marksman = {
        mason = false,
        enabled = (function()
          local bufnr = vim.api.nvim_get_current_buf()
          local is_md = vim.bo[bufnr].filetype == 'markdown'
          local is_modifiable = vim.bo[bufnr].modifiable

          if is_modifiable and is_md then
            return true -- Return true to enable
          end

          return false
        end)()
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

          --- @diagnostic disable-next-line: param-type-mismatch, generic-constraint-mismatch
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings or {}, --[[@as lsp.LSPObject?]] {
            typescript = options,
            javascript = options
          })
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
                    'sh',
                    '-c',
                    'pnpm list -g --json --long @astrojs/ts-plugin | '
                    .. "jq '.[0].dependencies.\"@astrojs/ts-plugin\".path' -r"
                  },
                  enableForWorkspaceTypeScriptVersions = true
                },
                {
                  name = '@vue/typescript-plugin',
                  location = vim.fn.system {
                    'sh',
                    '-c',
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
                    'sh',
                    '-c',
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
      end,
    }
  }
}
