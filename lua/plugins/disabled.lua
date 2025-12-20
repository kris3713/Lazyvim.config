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
  --   'tamago324/nlsp-settings.nvim',
  --   opts = {
  --     config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  --     local_settings_dir = '.nlsp-settings',
  --     local_settings_root_markers_fallback = { '.git' },
  --     append_default_schemas = true,
  --     loader = 'json'
  --   }
  -- },
  -- {
  --   'lervag/vimtex',
  --   -- harper:ignore
  --   -- lazy-loading will disable inverse search
  --   lazy = false,
  --   config = function()
  --     -- Disables `K` as it conflicts with LSP hover
  --     vim.g.vimtex_mappings_disable = {
  --       ['n'] = { 'K' }
  --     }
  --
  --     vim.g.vimtex_quickfix_method = vim.fn.executable('pplatex') == 1 and 'pplatex' or 'latexlog'
  --   end,
  --   keys = {
  --     { '<localLeader>l', '', desc = '+vimtex', ft = 'tex' }
  --   }
  -- },
  -- {
  --   'fedepujol/move.nvim',
  --   keys = {
  --     -- Normal Mode
  --     { '<A-j>', function() vim.cmd('MoveLine(1)') end, desc = 'Move Line Up' },
  --     { '<A-k>', function() vim.cmd('MoveLine(-1)') end, desc = 'Move Line Down' },
  --     { '<A-h>', function() vim.cmd('MoveHChar(-1)') end, desc = 'Move Character Left' },
  --     { '<A-l>', function() vim.cmd('MoveHChar(1)') end, desc = 'Move Character Right' },
  --     { '<leader>wf', function() vim.cmd('MoveWord(-1)') end, mode = { 'n' }, desc = 'Move Word Left' },
  --     { '<leader>wb', function() vim.cmd('MoveWord(1)') end, mode = { 'n' }, desc = 'Move Word Right' },
  --     -- Visual Mode
  --     { '<A-j>', function() vim.cmd('MoveBlock(-1)') end, mode = { 'v', 'x' }, desc = 'Move Block Up' },
  --     { '<A-k>', function() vim.cmd('MoveBlock(1)') end, mode = { 'v', 'x' }, desc = 'Move Block Down' },
  --     { '<A-h>', function() vim.cmd('MoveHBlock(-1)') end, mode = { 'v', 'x' }, desc = 'Move Block Left' },
  --     { '<A-l>', function() vim.cmd('MoveHBlock(1)') end, mode = { 'v', 'x' }, desc = 'Move Block Right' }
  --   },
  --   ---@type MoveConfig
  --   opts = {}
  -- },
  -- {
  --   'rcarriga/nvim-notify',
  --   opts = {}
  -- },
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
  --   'ray-x/navigator.lua',
  --   dependencies = {
  --     {
  --       'ray-x/guihua.lua',
  --       build = 'cd lua/fzy && make'
  --     }
  --   },
  --   opts = {}
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
