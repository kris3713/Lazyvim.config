return {
  -- Configuration for plugins already installed by LazyExtras or by LazyVim (by default)
  { -- Comment this out when PR #6505 is merged   https://github.com/LazyVim/LazyVim/pull/6505
    'LazyVim/LazyVim',
    url = 'https://github.com/comfysage/LazyVim.git',
    branch = 'fix/catppuccin/bufferline-api-change',
    version = false
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {
      file_types = { 'markdown' }
    },
    ft = { 'markdown' }
  },
  {
    'mason-org/mason.nvim',
    ---@module 'mason',
    ---@type MasonSettings
    opts = {
      registries = {
        'github:mason-org/mason-registry',
        'github:Crashdummyy/mason-registry'
      }
    }
  },
  {
    'folke/noice.nvim',
    ---@module 'noice'
    ---@type NoiceConfig
    opts = {
      lsp = {
        hover = { silent = true },
        message = { silent = true }
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    ---@module 'lspconfig'
    ---@type lspconfig.Config
    opts = {
      -- Disable inlay hints
      inlay_hints = { enabled = false }
    }
  },
  {
    'nvim-neotest/neotest',
    optional = true,
    dependencies = {
      'Issafalcon/neotest-dotnet'
    },
    opts = {
      adapters = {
        -- Here we can set options for neotest-dotnet
        ['neotest-dotnet'] = {}
      }
    }
  },
  {
    'akinsho/bufferline.nvim',
    ---@module 'bufferline'
    ---@type bufferline.Config
    opts = {
      options = {
        always_show_bufferline = true,
        separator_style = 'thick',
        hover = {
          enabled = true,
          delay = 120,
          reveal = { 'close' }
        }
      }
    }
  },
  {
    'folke/snacks.nvim',
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      explorer = { enabled = false },
      picker = {
        previewers = {
          diff = {
            builtin = false,
            cmd = { 'delta' }
          },
          git = {
            builtin = false
          },
          man_pager = 'nvim +Man!'
        }
      },
      win = { border = 'rounded' }
    },
    keys = {
      { '<leader>S', false }
    }
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      sections = {
        lualine_b = { 'branch', 'gitstatus' },
        lualine_c = {
          {
            'diagnostics',
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                require('trouble').toggle {
                  mode = 'diagnostics',
                  filter = { buf = bufnr }
                }
              end
            end
          }
        },
        lualine_x = {
          { 'encoding', show_bomb = true },
          {
            -- indent_style
            function()
              local bufnr = vim.api.nvim_get_current_buf()
              local indent_style = require('guess-indent').guess_from_buffer(bufnr)

              if indent_style ~= 'tabs' then
                return 'Indent Style: Spaces'
              else
                return 'Indent Style: Tabs'
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                require('functions.switch_indent_style').switch_indent_style(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh()
              end
            end
          },
          {
            -- indent_size
            function()
              local bufnr = vim.api.nvim_get_current_buf()
              local indent_style = require('guess-indent').guess_from_buffer(bufnr)

              if indent_style ~= 'tabs' then
                return 'Indent Size: ' .. vim.bo[bufnr].shiftwidth
              else
                return 'Indent Size: ' .. vim.bo[bufnr].tabstop
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                require('functions.set_indent_size_prompt').set_indent_size(bufnr)
                -- Force Lualine to refresh to reflect the change immediately
                require('lualine').refresh()
              end
            end
          },
          {
            -- fileformat
            function()
              local bufnr = vim.api.nvim_get_current_buf()

              if vim.bo[bufnr].fileformat == 'unix' then
                return 'LF (unix)'
              elseif vim.bo[bufnr].fileformat == 'dos' then
                return 'CRLF (dos)'
              elseif vim.bo[bufnr].fileformat == 'mac' then
                return 'CR (mac)'
              else
                return vim.bo[bufnr].fileformat
              end
            end,
            ---@param clicks integer
            on_click = function(clicks, _, _)
              local bufnr = vim.api.nvim_get_current_buf()

              if clicks == 2 then
                if vim.bo[bufnr].fileformat == 'unix' then
                  vim.bo[bufnr].fileformat = 'dos'
                elseif vim.bo[bufnr].fileformat == 'dos' then
                  vim.bo[bufnr].fileformat = 'mac'
                elseif vim.bo[bufnr].fileformat == 'mac' then
                  vim.bo[bufnr].fileformat = 'unix'
                end
                require('lualine').refresh()
              end
            end
          },
          {
            'filetype',
            ---@param clicks integer
            on_click = function(clicks, _, _)
              if clicks == 2 then
                require('telescope.builtin').filetypes()
              end
            end
          }
        },
        lualine_y = { 'searchcount', 'selectioncount', 'progress' },
        lualine_z = { 'location' }
      }
    }
  },
  {
    'mfussenegger/nvim-dap',
    optional = true,
    opts = function()
      local dap = require('dap')

      if not dap.adapters['netcoredbg'] then
        require('dap').adapters['netcoredbg'] = {
          type = 'executable',
          command = vim.fn.exepath('netcoredbg'),
          args = { '--interpreter=vscode' },
          options = {
            detached = false
          }
        }
      end

      for _, lang in ipairs { 'cs', 'fsharp', 'vb' } do
        if not dap.configurations[lang] then
          dap.configurations[lang] = {
            {
              type = 'netcoredbg',
              name = 'Launch file',
              request = 'launch',
              ---@diagnostic disable-next-line: redundant-parameter
              program = function()
                return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/', 'file')
              end,
              cwd = '${workspaceFolder}'
            }
          }
        end
      end
    end
  }
}
