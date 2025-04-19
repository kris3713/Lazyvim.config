return {
  -- Plugins with configs go here
  {
    'nanotee/zoxide.vim',
    init = function() vim.g.zoxide_use_select = 1 end
  },
  {
    'fei6409/log-highlight.nvim',
    config = true
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = { snippetDir = vim.uv.os_homedir() .. '/MEGA' }
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('toggleterm').setup {}
    end
  },
  {
    'AckslD/muren.nvim',
    config = true
  },
  {
    'nvzone/volt',
    lazy = true
  },
  {
    'nvzone/minty',
    config = true,
    cmd = { 'Shades', 'Heufy' }
  },
  {
    'jmbuhr/otter.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('otter').setup {}
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      -- Has potential for a complex configuration
      require('nvim-autopairs').setup {}
    end
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = true
  },
  {
    'lewis6991/satellite.nvim',
    config = true
  },
  {
    'nacro90/numb.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('numb').setup {}
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      -- Has potential for a complex configuration
      require('ts_context_commentstring').setup { enable_autocmd = false }
    end
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    config = true
  },
  {
    'zeioth/garbage-day.nvim',
    event = 'VeryLazy',
    opts = {
      -- Put misbehaving lsp clients here
      excluded_lsp_clients = { 'marksman' }
    }
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      -- Has potential for a complex configuration
      require('nvim-ts-autotag').setup {
        opts = { enable_close_on_slash = true }
      }
    end
  },
  {
    'Wansmer/treesj',
    keys = { '<leader>m', '<leader>j' },
    config = function()
      -- Has potential for a complex configuration
      require('treesj').setup {}
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    ---@module 'lspsaga'
    ---@type LspsagaConfig
    opts = {
      symbol_in_winbar = { enable = false }
    }
  },
  {
    'm-demare/hlargs.nvim',
    opts = {
      color = '#ed8796'
    }
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    ---@module 'yazi'
    ---@type YaziConfig
    opts = {
      open_for_directories = true
    }
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      -- Has potential for a complex configuration
      local c = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup {
        pre_hook = c.create_pre_hook()
      }
    end
  },
  {
    'zbirenbaum/neodim',
    event = 'LspAttach',
    ---@module 'neodim'
    ---@type neodim.Options
    opts = {
      hide = {
        underline = true,
        virtual_text = false,
        signs = true
      }
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function()
      -- Has potential for a complex configuration
      require('ufo').setup {
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },
  {
    'ray-x/lsp_signature.nvim',
    event = 'InsertEnter',
    opts = {
      bind = true,
      handler_opts = {
        border = 'rounded'
      },
      hint_prefix = '❔ ',
      transparency = 90
    }
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    event = 'ModeChanged *:[vV\22]',
    opts = {
      space_char = '·',
      tab_char = '󰌒 '
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    ---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = { border = 'rounded' }
      }
    }
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        insert = '<Nop>',
        insert_line = '<Nop>',
        normal = 'gss',
        normal_cur = 'gss',
        normal_line = 'gsS',
        normal_cur_line = 'gsSs',
        visual = 'gss',
        visual_line = 'gsS',
        delete = 'gsd',
        change = 'gsc',
        change_line = 'gsC'
      }
    }
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      -- Has potential for a more complex configuration
      require('actions-preview').setup {
        backend = 'telescope',
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            -- height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 25,
            ---@param max_lines number
            preview_height = function(_, _, max_lines)
              return max_lines - 20
            end
          }
        },
        highlight_command = {
          require('actions-preview.highlight').delta()
        }
      }
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    config = function()
      -- Has potential for a more complex configuration
      require('nvim-tree').setup {
        filters = { enable = false },
        ---@param bufnr number
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function edit_or_open()
            local node = api.tree.get_node_under_cursor()
            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file
              api.node.open.edit()
              -- Close the tree if file was opened
              api.tree.close()
            end
          end

          -- harper:ignore
          -- open as vsplit on current node
          local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()
            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file as vsplit
              api.node.open.vertical()
            end
            -- Finally refocus on tree if it was lost
            api.tree.focus()
          end

          --- (Copied from eddiebergman)
          ---@param desc string
          ---@return table
          local function opts(desc)
            return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings (Copied from eddiebergman)
          api.config.mappings.default_on_attach(bufnr)

          -- Set keymaps on attach (Copied from eddiebergman)
          vim.keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
          vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
          vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
          vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))
        end,
        renderer = {
          icons = {
            glyphs = {
              git = {
                unstaged = '󰄱',
                staged = '󰱒'
              }
            }
          }
        }
      }
    end,
    deactivate = function() vim.cmd('NvimTreeClose') end
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true
      },
      lazy_support = true,
      suppressed_dirs = { vim.uv.os_homedir(), '/' },
      cwd_change_handling = true,
      pre_restore_cmds = {
        function()
          ---@param name string
          local function create_augroup(name)
            return vim.api.nvim_create_augroup(name, { clear = true })
          end

          -- Enforce Unix-style line endings for all files
          vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'WinEnter' }, {
            group = create_augroup('change_line_ending'),
            desc = 'Ensure that all files have Unix-style line endings',
            pattern = '*',
            callback = function()
              local is_true = (vim.bo.filetype ~= 'help') or (vim.bo.filetype ~= 'man') or (vim.bo.filetype ~= 'gitcommit')
              if is_true and vim.bo.modifiable then
                vim.bo.fileformat = 'unix'
                vim.o.fileformats = 'unix,dos,mac'
              end
            end
          })

          -- Ensure all docker compose files are set as `yaml.docker-compose`
          vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'WinEnter' }, {
            group = create_augroup('enforce_filetype_for_certain_files'),
            desc = 'Enforce certain files to be a certain filetype',
            callback = function()
              -- VSCode config files and TypeScript config files
              local vscode__and__ts_names = {
                'settings.json',
                'launch.json',
                'tasks.json',
                'launch.json',
                'tsconfig.json',
                'jsconfig.json'
              }

              for _, name in ipairs(vscode__and__ts_names) do
                if (vim.fn.expand('%:t') == name) and (vim.bo.filetype ~= 'jsonc') then
                  vim.bo.filetype = 'jsonc'
                  -- vim.cmd.setfiletype('jsonc')
                end
              end
            end
          })
        end
      }
    }
  }
  -- harper:ignore
  --- Might use again if needed.
  -- {
  --   'ray-x/navigator.lua',
  --   dependencies = { 'ray-x/guihua.lua' },
  --   config = function()
  --     -- Has potential for a complex configuration
  --     require('navigator').setup()
  --   end
  -- },
  -- { -- Copied and modified from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/neo-tree.lua
  --   'nvim-neo-tree/neo-tree.nvim',
  --   --- @module 'neo-tree'
  --   --- @type neotree.Config
  --   opts = {
  --     filesystem = {
  --       bind_to_cwd = false,
  --       follow_current_file = { enabled = true },
  --       use_libuv_file_watcher = true,
  --       hijack_netrw_behavior = 'open_current',
  --       filtered_items = {
  --         visible = true,
  --         hide_dotfiles = false,
  --         hide_gitignored = false
  --       }
  --     }
  --   }
  -- },
  -- { -- Needed by neotree
  --   's1n7ax/nvim-window-picker',
  --   name = 'window-picker',
  --   event = 'VeryLazy',
  --   config = true
  -- },
  -- {
  --   'soulis-1256/eagle.nvim',
  --   opts = {
  --     border = 'rounded'
  --   }
  -- },
  -- {
  --   'catgoose/nvim-colorizer.lua',
  --   event = 'BufReadPre',
  --   opts = {}
  -- },
  -- {
  --   'kdheepak/lazygit.nvim',
  --   lazy = false,
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile'
  --   },
  --   keys = {
  --       { '<leader>gg', function() vim.cmd('LazyGit') end, desc = 'LazyGit', noremap = true }
  --   },
  --   config = function()
  --     require('telescope').load_extension('lazygit')
  --   end
  -- },
}
