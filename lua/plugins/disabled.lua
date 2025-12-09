return {
  -- Disabled plugins go here
  {
    'nvim-mini/mini.ai',
    enabled = false
  },
  {
    'stevearc/conform.nvim',
    enabled = false
  },
  {
    'mfussenegger/nvim-lint',
    enabled = false
  },
  {
    'mini.pairs',
    enabled = false
  },
  {
    'folke/persistence.nvim',
    enabled = false
  }
  -- harper:ignore
  -- {
  --   'ray-x/go.nvim',
  --   dependencies = { 'ray-x/guihua.lua' },
  --   config = function ()
  --     require('go').setup {}
  --   end,
  --   event = 'CmdlineEnter',
  --   ft = { 'go', 'gomod' },
  --   build = function() require('go.install').update_all_sync() end
  -- },
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   event = 'InsertEnter',
  --   opts = {
  --     bind = true,
  --     handler_opts = {
  --       border = 'rounded'
  --     },
  --     hint_prefix = '❔ '
  --   }
  -- },
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
  -- {
  --   'milanglacier/minuet-ai.nvim',
  --   opts = {
  --     -- notify = 'verbose',
  --     provider = 'gemini',
  --     provider_options = {
  --       gemini = {
  --         model = 'gemini-2.0-flash',
  --         optional = {
  --           generationConfig = {
  --             maxOutputTokens = 256,
  --             -- When using `gemini-2.5-flash`, it is recommended to entirely
  --             -- disable thinking for faster completion retrieval.
  --             thinkingConfig = {
  --               thinkingBudget = 0
  --             }
  --           },
  --           safetySettings = {
  --             {
  --               -- HARM_CATEGORY_HATE_SPEECH,
  --               -- HARM_CATEGORY_HARASSMENT
  --               -- HARM_CATEGORY_SEXUALLY_EXPLICIT
  --               category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
  --               -- BLOCK_NONE
  --               threshold = 'BLOCK_ONLY_HIGH'
  --             }
  --           }
  --         }
  --       }
  --     }
  --   }
  -- },
  -- {
  --   'nvim-zh/colorful-winsep.nvim',
  --   config = function()
  --     require('colorful-winsep').setup {
  --       excluded_ft = { 'packer', 'TelescopePrompt', 'mason', 'NvimTree' },
  --       animate = {
  --         enabled = 'progressive'
  --       }
  --     }
  --   end,
  --   event = { 'WinLeave' }
  -- },
}
