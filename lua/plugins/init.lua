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
    config = true
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
    cmd = { 'Shades', 'Heufy' }
  },
  {
    'jmbuhr/otter.nvim',
    opts = {}
  },
  {
    'mtoohey31/cmp-fish',
    ft = 'fish'
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = function()
      require('hlslens').setup {}
    end
  },
  {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup {}
    end
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup {}
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require('ts_context_commentstring').setup { enable_autocmd = false }
    end
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    opts = {} -- your configuration
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
    config = function ()
      require('nvim-ts-autotag').setup {}
    end
  },
  {
    'Wansmer/treesj',
    keys = { '<leader>m', '<leader>j' },
    config = function()
      require('treesj').setup {}
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {
        symbol_in_winbar = { enable = false }
      }
    end
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      require('hlargs').setup {
        color = '#ed8796'
      }
    end
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
      local c = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup {
        pre_hook = c.create_pre_hook()
      }
    end
  },
  {
    'zbirenbaum/neodim',
    event = 'LspAttach',
    config = function()
      require('neodim').setup {
        hide = {
          underline = true,
          virtual_text = false,
          signs = true
        }
      }
    end
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function ()
      require('ufo').setup {
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    event = 'ModeChanged *:[vV\22]',
    ---@module 'visual-whitespace'
    opts = {
      space_char = '·',
      tab_char = '󰌒 '
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    config = function()
      require('dropbar').setup {
        menu = {
          win_configs = { border = 'rounded' }
        }
      }
    end
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function ()
      require('nvim-surround').setup {
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
    end
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      require('actions-preview').setup({
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
      })
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    config = function()
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
                vim.o.fileformat = 'unix'
                vim.o.fileformats = 'unix,dos,mac'
              end
            end
          })

          -- Ensure all docker compose files are set as `yaml.docker-compose`
          vim.api.nvim_create_autocmd({ 'BufEnter', 'BufRead', 'WinEnter' }, {
            group = create_augroup('set_docker_compose_filetype'),
            desc = 'Set docker-compose filetype to `yaml.docker-compose`',
            callback = function()
              local names = { 'docker-compose.yaml', 'docker-compose.yml', 'compose.yaml', 'compose.yml' }

              for _, name in ipairs(names) do
                if (vim.fn.expand('%:t') == name) and (vim.bo.filetype ~= 'yaml.docker-compose') then
                  vim.o.filetype = 'yaml.docker-compose'
                  -- vim.cmd.setfiletype('yaml.docker-compose')
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
  --   config = function ()
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
