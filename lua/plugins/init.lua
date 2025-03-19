return {
  -- No config plugins go here
  'HiPhish/rainbow-delimiters.nvim',
  'aznhe21/actions-preview.nvim',
  'nanotee/zoxide.vim',
  'numToStr/Comment.nvim',
  'nvim-tree/nvim-web-devicons',
  'MunifTanjim/nui.nvim',
  'nvimtools/none-ls-extras.nvim',
  'cappyzawa/trim.nvim',
  -- Plugins with configs go here
  { -- Set syntax highlighting for logs
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup()
    end
  },
  { -- Activate csharp.nvim
    'iabdelkareem/csharp.nvim',
    dependencies = {
      'mfussenegger/nvim-dap',
      'Tastyep/structlog.nvim' -- Optional, but highly recommended for debugging
    },
    config = function ()
      -- require('mason').setup() -- Mason setup must run before csharp, only if you want to use omnisharp
      require('csharp').setup {
        lsp = {
          omnisharp = { enable = false },
          roslyn = {
            enable = true,
            cmd_path = os.getenv('ROSLYN_LSP') .. '/Microsoft.CodeAnalysis.LanguageServer.dll'
          }
        }
      }
    end
  },
  { -- Activate lazygit.nvim
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile'
    }
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---enables autocomplete for opts
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '/' }
    }
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    config = true
  },
  -- {
  --   'akinsho/bufferline.nvim',
  --   opts = function(_, opts)
  --     if (vim.g.colors_name or ''):find('catppuccin') then
  --       opts.highlights = require('catppuccin.groups.integrations.bufferline').get()
  --     end
  --   end
  -- },
  {
    'antosha417/nvim-lsp-file-operations',
    config = function ()
      require('lsp-file-operations').setup()
    end
  },
  { -- Copied and modified from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/neo-tree.lua
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    deactivate = function() vim.api.nvim_command('Neotree close') end,
    --- @module 'neo-tree'
    --- @type neotree.Config
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'open_current',
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all 'hide' just mean 'dimmed out'
          hide_dotfiles = false,
          hide_gitignored = false
        }
      },
      window = {
        mappings = {
          ['l'] = 'open',
          ['h'] = 'close_node',
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard'
          },
          ['O'] = {
            function(state)
              require('lazy.util').open(state.tree:get_node().path, { system = true })
            end,
            desc = 'Open with System Application'
          },
          ['P'] = { 'toggle_preview', config = { use_float = false } }
        }
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander'
        },
        git_status = {
          symbols = {
            unstaged = '󰄱',
            staged = '󰱒'
          }
        }
      }
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require('neo-tree.events')
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move }
      })
      require('neo-tree').setup(opts)
      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end
      })
    end
  }
}
