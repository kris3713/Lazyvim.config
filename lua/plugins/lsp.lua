-- MSBuild
local msbuild = os.getenv('MSBUILD_LSP')

-- capabilities
local function capabilities()
  local client_capabilities = vim.lsp.protocol.make_client_capabilities()
  client_capabilities.textDocument.completion.completionItem.snippetSupport = true
  return client_capabilities
end

return {
  'neovim/nvim-lspconfig',
  opts = {
    servers = {
      -- bashls
      bashls = { mason = false },
      -- biome
      biome = { mason = false },
      -- dockerls
      dockerls = { mason = false },
      -- docker_compose_language_service
      docker_compose_language_service = { mason = false },
      -- eslint
      eslint = { mason = false },
      -- prismals
      prismals = { mason = false },
      -- pyright
      pyright = { mason = false },
      -- tailwindcss
      tailwindcss = { mason = false },
      -- vimls
      vimls = { mason = false },
      -- cssls
      cssls = {
        mason = false,
        capabilities = capabilities()
      },
      -- powershell_es
      powershell_es = {
        settings = {
          bundle_path = vim.fn.stdpath('data') .. '/mason/packages/powershell-editor-services'
        }
      },
      -- html
      html = {
        mason = false,
        capabilities = capabilities()
      },
      -- MSBuild
      msbuild_project_tools_server = {
        enabled = msbuild ~= nil and msbuild ~= '',
        -- enable = msbuild ~= nil and msbuild ~= '',
        cmd = { 'dotnet', msbuild .. '/MSBuildProjectTools.LanguageServer.Host.dll' }
      },
      -- csharp_ls
      csharp_ls = {
        settings = {
          AutomaticWorkspaceInit = true
        }
      },
      -- Harper
      harper_ls = {
        mason = false,
        settings = {
          ['harper-ls'] = {
            userDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt',
            fileDictPath = vim.uv.os_homedir() .. '/MEGA/harperdict.txt'
          }
        }
      },
      -- cssmodules_ls
      cssmodules_ls = {
        mason = false,
        filetypes = {
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact',
          'astro',
          'vue',
          'svelte'
        }
      },
      -- jsonls
      jsonls = {
        mason = false,
        capabilities = capabilities(),
        ---@param new_config vim.lsp.config
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(
            new_config.settings.json.schemas,
            require('schemastore').json.schemas()
          )
        end,
        settings = {
          json = {
            format = { enable = true },
            validate = { enable = true }
          }
        },
      },
      yamlls = {
        mason = false,
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true
            }
          }
        },
        ---@param new_config vim.lsp.config
        on_new_config = function(new_config)
          new_config.settings.yaml.schemas = vim.tbl_deep_extend(
            'force',
            new_config.settings.yaml.schemas or {},
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
      lua_ls = {
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
      marksman = {
        settings = {
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
        }
      },
      gopls = {
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
      -- vtsls
      vtsls = {
        mason = false,
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
    }
  }
}
