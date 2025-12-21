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

---Opens the hover window
local function hover_open()
  -- hover.nvim
  local hover = require('hover')
  hover.open {}
end

---Selects a code action available at the current cursor position.
local function ap__code_actions()
  -- actions-preview
  local ap = require('actions-preview')
  ap.code_actions {}
end


return {
  'kris3713/nvim-lspconfig', -- switch back to neovim/nvim-lspconfig
  branch = 'systemd_lsp',
  ---@module 'annotations.lsp'
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
          { -- Hover Doc
            'K',
            hover_open,
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
      systemd_lsp = {
        enabled = true
      },
      -- rubocop
      rubocop = {
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
      -- stylelint_lsp
      stylelint_lsp = {
        enabled = true
      },
      -- gh_actions_ls
      gh_actions_ls = {
        enabled = true
      },
      -- gradle_ls
      gradle_ls = {
        enabled = true
      },
      -- golangci_lint_ls
      golangci_lint_ls = {
        enabled = true
      },
      -- jdtls
      jdtls = {
        enabled = true
      },
      -- statix
      statix = {
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
        enabled = true
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
      -- basedpyright
      basedpyright = {
        mason = false,
        enabled = false
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
      -- jedi_language_server
      jedi_language_server = {
        mason = false,
        enabled = false
      },
      -- pyright
      pyright = {
        mason = false,
        enabled = false
      },
      -- pyrefly
      pyrefly = {
        mason = false,
        enabled = true
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
      -- ruff
      ruff = {
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
        enabled = true,
        capabilities = capabilities()
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

          for _, ft in ipairs(new_filetypes) do
            table.insert(filetypes, ft)
          end

          local sort = table.sort

          --- @diagnostic disable-next-line: undefined-field
          sort(filetypes)

          return filetypes
        end)()
      },
      -- jsonls
      jsonls = {
        enabled = true,
        mason = false,
        capabilities = capabilities(),
        ---@param new_config vim.lsp.ClientConfig
        on_new_config = function(new_config)
          ---@diagnostic disable-next-line: undefined-field, need-check-nil
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(
            ---@diagnostic disable-next-line: undefined-field, need-check-nil
            new_config.settings.json.schemas,
            require('schemastore').json.schemas()
          )
        end,
        settings = {
          json = {
            format = {
              enable = true
            },
            validate = {
              enable = true
            }
          }
        },
      },
      -- yamlls
      yamlls = {
        mason = false,
        enabled = true,
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
          }
        },
        ---@param new_config vim.lsp.ClientConfig
        on_new_config = function(new_config)
          --- @diagnostic disable-next-line: need-check-nil, assign-type-mismatch
          new_config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            --- @diagnostic disable-next-line: need-check-nil, generic-constraint-mismatch
            new_config.settings.yaml.schemas or {},
            --- @diagnostic disable-next-line: param-type-mismatch
            require('schemastore').yaml.schemas()
          )
        end,
        settings = {
          yaml = {
            schemaStore = {
              -- You must disable built-in schemaStore support if you want to use
              -- this plugin and its advanced options like `ignore`.
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
            'sh',
            'spec'
          }

          for _, ft in ipairs(new_filetypes) do
            table.insert(filetypes, ft)
          end

          local sort = table.sort

          --- @diagnostic disable-next-line: undefined-field
          sort(filetypes)

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
        mason = false
        -- ---@param bufnr integer
        -- enabled = function(bufnr)
        --   local is_md = vim.bo[bufnr].filetype == 'markdown'
        --
        --   if vim.bo[bufnr].modifiable and is_md then
        --     return true -- Return true to enable
        --   end
        --
        --   return false
        -- end,
        -- settings = {
        --   ---@param bufnr integer
        --   autostart = function(bufnr)
        --     local is_md = vim.bo[bufnr].filetype == 'markdown'
        --
        --     if vim.bo[bufnr].modifiable and is_md then
        --       return true -- return true to allow autostart
        --     end
        --
        --     return false
        --   end
        -- }
      },
      -- marksman
      marksman = {
        enabled = true
        -- ---@param bufnr integer
        -- enabled = function(bufnr)
        --   local is_md = (vim.bo[bufnr].filetype == 'markdown') or (vim.bo[bufnr].filetype == 'markdown.mdx')
        --
        --   if vim.bo[bufnr].modifiable and is_md then
        --     return true -- Return true to enable
        --   end
        --
        --   return false -- Otherwise, return false to not enable
        -- end,
        -- settings = {
        --   -- This solves the problem of Marksman exiting when a new hover doc buffer (from Lspsaga) is created
        --   ---@param bufnr integer
        --   autostart = function(bufnr)
        --     local is_md = (vim.bo[bufnr].filetype == 'markdown') or (vim.bo[bufnr].filetype == 'markdown.mdx')
        --
        --     if vim.bo[bufnr].modifiable and is_md then
        --       return true -- Return true to allow autostart
        --     end
        --
        --     return false -- Otherwise, return false to prevent autostart
        --   end
        -- }
      },
      -- vtsls
      vtsls = {
        mason = false,
        enabled = true,
        ---@param client vim.lsp.Client
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
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            typescript = options,
            javascript = options
          })
        end,
        settings = {
          vtsls = {
            experimental = { enableProjectDiagnostics = true }
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
      -- stylua
      stylua = {
        mason = false,
        enabled = false
      },
      -- texlab
      texlab = {
        enabled = false
      }
    }
  }
}
