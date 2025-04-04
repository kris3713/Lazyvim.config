return {
  -- Plugins with configs go here
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    config = function ()
      local nvim_surround = require('nvim-surround')

      nvim_surround.setup {
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
    config = true
  },
  {
    'numToStr/Comment.nvim',
    config = true
  },
  {
    'nanotee/zoxide.vim',
    init = function() vim.g.zoxide_use_select = 1 end
  },
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = true
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = { suppressed_dirs = { '~/', '/' } }
  },
  {
    'antosha417/nvim-lsp-file-operations',
    config = true
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = { snippetDir = '~/MEGA/' }
  },
  {
    'akinsho/toggleterm.nvim',
    config = true
  },
  { -- Needed by neotree
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    config = true
  },
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {}
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    opts = {} -- your configuration
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      -- keymaps = { show_help = '<f1>' }
    }
  },
  {
    'soulis-1256/eagle.nvim',
    opts = {
      show_lsp_info = false
    }
  },
  {
    'm-demare/hlargs.nvim',
    config = function()
      -- Will modify later...
      require('hlargs').setup {
        color = '#ed8796'
      }
    end
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    config = function ()
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'treesitter', 'indent' }
        end
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
    'AckslD/muren.nvim',
    config = true
  },
  {
    'zeioth/garbage-day.nvim',
    event = 'VeryLazy',
    opts = {
      -- Put misbehaving lsp clients here
      excluded_lsp_clients = {
        'marksman'
      }
    }
  },
  {
    'windwp/nvim-ts-autotag',
    config = function ()
      require('nvim-ts-autotag').setup {}
    end
  },
  {
    'glepnir/nerdicons.nvim',
    cmd = 'NerdIcons',
    config = function()
      require('nerdicons').setup {}
    end
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
    end
  },
  {
    'Wansmer/treesj',
    keys = { '<leader>m', '<leader>j', '<leader>a' },
    config = function()
      require('treesj').setup({})
    end
  },
  {
    'nacro90/numb.nvim',
    config = function()
      require('numb').setup {}
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}
  },
  {
    'gbprod/substitute.nvim',
    opts = {} -- For configuring later
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
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    config = function()
      require('nvim-tree').setup {
        filters = { dotfiles = false }
      }
    end,
    opts = {
      on_attach = function(bufnr)
        -- Get nvim-tree api
        local api = require('nvim-tree.api')

        -- Get node under cursor (Copied from eddiebergman)
        local node = api.tree.get_node_under_cursor()

        -- (Copied from eddiebergman)
        local function edit_or_open()
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

        -- (Copied from eddiebergman)
        local function vsplit_preview()
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

        -- opts function (from eddiebergman)
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
      end
    },
    deactivate = function() vim.cmd('NvimTreeClose') end
  },
  --- Might use again if needed.
  -- {
  --   'iabdelkareem/csharp.nvim',
  --   config = function()
  --     ROSLYN_LSP = os.getenv('ROSLYN_LSP')
  --
  --     -- Don't even bother loading if ROSLYN_LSP is not set
  --     if ROSLYN_LSP == nil then return end
  --
  --     require('csharp').setup {
  --       lsp = {
  --         omnisharp = { enable = false },
  --         roslyn = {
  --           enable = true,
  --           cmd_path = ROSLYN_LSP .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
  --         }
  --       }
  --     }
  --   end
  -- },
  -- {
  --   'mfussenegger/nvim-lint',
  --   config = function()
  --     require('lint').linters_by_fit = {}
  --   end
  -- },
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   opts = {}
  -- },
  -- {
  --   'mcauley-penney/visual-whitespace.nvim',
  --   version = '>=0.11',
  --   config = true,
  --   opts = { space_char = '·' }
  -- },
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
}
