return  --[[@type (LazyPluginSpec[])]]{
  -- Disabled plugins go here
  {
    'stevearc/conform.nvim',
    enabled = false,
  },
  {
    'mfussenegger/nvim-lint',
    enabled = false,
  },
  {
    'mini.pairs',
    enabled = false,
  },
  {
    'folke/persistence.nvim',
    enabled = false,
  },
  -- harper:ignore
  -- {
  --   'saecki/live-rename.nvim',
  --   opts = {}
  -- },
  -- {
  --   'lewis6991/hover.nvim',
  --   ---@type Hover.Config
  --   opts = {
  --     providers = {
  --       'hover.providers.lsp'
  --       -- 'hover.providers.man',
  --       -- 'hover.providers.dap'
  --     },
  --     preview_opts = { border = 'rounded' }
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
