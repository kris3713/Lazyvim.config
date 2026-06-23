---@diagnostic disable: missing-fields
---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'ThePrimeagen/refactoring.nvim', ---@module 'refactoring'
    ---@type refactor.UserConfig
    opts = {},
    dependencies = {
      { 'lewis6991/async.nvim', lazy = true },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local refactoring = require('refactoring')
      local modes = { 'n', 'x' }

      keys = {
        {
          '<leader>r',
          '',
          desc = '+refactor',
          mode = modes,
        },
        {
          '<leader>rs',
          function()
            refactoring.select_refactor()
          end,
          desc = 'Select Refactor',
          mode = modes,
        },
        {
          '<leader>re',
          '',
          desc = '+inline operations',
          mode = modes,
        },
        {
          '<leader>rev',
          function()
            return refactoring.inline_var()
          end,
          desc = 'Inline Variable',
          mode = modes,
          expr = true,
        },
        {
          '<leader>ref',
          function()
            return refactoring.inline_func()
          end,
          desc = 'Inline Function',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rx',
          '',
          desc = '+extraction operations',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rxv',
          function()
            return refactoring.extract_var()
          end,
          desc = 'Extract Variable',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rxf',
          function()
            return refactoring.extract_func()
          end,
          desc = 'Extract Function',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rxF',
          function()
            return refactoring.extract_func_to_file()
          end,
          desc = 'Extract Function To File',
          mode = modes,
          expr = true,
        },
      }

      return keys
    end,
  },
  {
    'neovim-plugins/comment.nvim', ---@module 'Comment'
    ---@param opts CommentConfig?
    opts = function(_, opts)
      if opts then
        local c = require('ts_context_commentstring.integrations.comment_nvim')
        opts.pre_hook = c.create_pre_hook()
      end
    end,
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring', ---@module 'ts_context_commentstring'
    ---@type ts_context_commentstring.Config
    opts = { enable_autocmd = false },
  },
  {
    'jake-stewart/multicursor.nvim', ---@module 'multicursor-nvim'
    ---@type mc.MultiCursorOpts
    opts = {},
    branch = '1.0',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local mc = require('multicursor-nvim')
      local modes = { 'n', 'x' }

      keys = {
        {
          '<leader>m',
          '',
          desc = '+multicursor',
          mode = modes,
        },
        {
          '<leader>m<up>',
          function()
            mc.lineAddCursor(-1)
          end,
          desc = 'Add a cursor above the main cursor, skipping empty lines',
          mode = modes,
        },
        {
          '<leader>m<down>',
          function()
            mc.lineAddCursor(1)
          end,
          desc = 'Add a cursor below the main cursor, skipping empty lines',
          mode = modes,
        },
        {
          '<leader>m<left>',
          function()
            mc.lineSkipCursor(-1)
          end,
          desc = 'Move only the main cursor up a line, skipping empty lines',
          mode = modes,
        },
        {
          '<leader>m<right>',
          function()
            mc.lineSkipCursor(1)
          end,
          desc = 'Move only the main cursor down a line, skipping empty lines',
          mode = modes,
        },
        {
          '<leader>mn',
          function()
            mc.matchAddCursor(1)
          end,
          desc = 'Add a new cursor by matching the current word/selection. Backwards',
          mode = modes,
        },
        {
          '<leader>ms',
          function()
            mc.matchSkipCursor(1)
          end,
          desc = 'Move only the main cursor by matching the current word/selection. Backwards',
          mode = modes,
        },
        {
          '<leader>mN',
          function()
            mc.matchAddCursor(-1)
          end,
          desc = 'Add a new cursor by matching the current word/selection. Forwards',
          mode = modes,
        },
        {
          '<leader>mS',
          function()
            mc.matchSkipCursor(-1)
          end,
          desc = 'Move only the main cursor by matching the current word/selection. Forwards',
          mode = modes,
        },
        {
          '<a-leftmouse>',
          mc.handleMouse,
          desc = 'add/remove cursors with mouse click',
          mode = 'n',
        },
        {
          '<a-leftdrag>',
          mc.handleMouseDrag,
          desc = 'add/remove cursors with (vertical) mouse drag',
          mode = 'n',
        },
        {
          '<a-leftrelease>',
          mc.handleMouseRelease,
          desc = 'Improve mouse support when dragging with a modifier',
          mode = 'n',
        },
        {
          '<leader>mq',
          mc.toggleCursor,
          desc = 'Disable and enable cursors',
          mode = modes,
        },
      }

      return keys
    end,
    init = function()
      local set_hl = vim.api.nvim_set_hl
      local reverse = { reverse = true }
      local visual = { link = 'Visual' }
      local sign_column = { link = 'SignColumn' }

      -- Customize how cursors look.
      set_hl(0, 'MultiCursorCursor', reverse)
      set_hl(0, 'MultiCursorVisual', visual)
      set_hl(0, 'MultiCursorSign', sign_column)
      set_hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
      set_hl(0, 'MultiCursorDisabledCursor', reverse)
      set_hl(0, 'MultiCursorDisabledVisual', visual)
      set_hl(0, 'MultiCursorDisabledSign', sign_column)
    end,
  },
  {
    'kylechui/nvim-surround', ---@module 'nvim-surround'
    ---@type user_options
    opts = {
      surrounds = {
        ['|'] = {
          add = { '|', '|' },
          delete = '^(.)().-(.)()$',
          find = function()
            return require('nvim-surround.config').get_selection({ motion = 'a|' })
          end,
          label = '|...|',
        },
      },
    },
    version = '*',
    event = 'VeryLazy',
  },
  {
    'windwp/nvim-autopairs',
    opts = { map_bs = false },
    init = function()
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')

      npairs.add_rule(Rule('|', '|', { 'rust' }))
    end,
    event = 'InsertEnter',
  },
  {
    'cappyzawa/trim.nvim',
    opts = {
      -- harper:ignore
      -- if you want to ignore markdown file.
      -- you can specify filetypes.
      ft_blocklist = {
        'snacks_dashboard',
        'snacks_terminal',
      },
      -- harper:ignore
      -- if you want to disable trim on write by default
      trim_on_write = false,
      -- highlight trailing spaces
      highlight = true,
    },
    keys = {
      {
        '<leader>T',
        function()
          vim.cmd('Trim')
        end,
        desc = 'Trim all trailing whitespaces and lines',
        mode = 'n',
      },
    },
  },
  {
    'qwavies/smart-backspace.nvim',
    opts = {},
    event = { 'InsertEnter', 'CmdlineEnter' },
    keys = {
      {
        '<leader>B',
        function()
          vim.cmd('SmartBackspaceToggle')
        end,
        desc = 'Toggle Smart Backspace',
        mode = 'n',
      },
    },
  },
  {
    'chrisgrieser/nvim-origami', ---@module 'origami'
    ---@type Origami.config
    opts = {
      autoFold = { enabled = false },
      foldKeymaps = { setup = false },
    },
    event = 'VeryLazy',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local origami = require('origami')

      keys = {
        {
          'zR',
          origami.dollar,
          desc = 'Open all folds',
          mode = 'n',
        },
        {
          'zM',
          origami.caret,
          desc = 'Close all folds',
          mode = 'n',
        },
      }

      return keys
    end,
  },
  {
    'andymass/vim-matchup', ---@module 'match-up'
    ---@type matchup.Config
    opts = {
      treesitter = {
        stopline = 500,
      },
    },
  },
  {
    'windwp/nvim-ts-autotag', ---@module 'nvim-ts-autotag'
    ---@type nvim-ts-autotag.PluginSetup
    opts = {
      --- @diagnostic disable-next-line: param-type-mismatch
      -- Has potential for a complex configuration
      opts = {
        enable_close = true,
        enable_close_on_slash = true,
        enable_rename = true,
      },
    },
  },
  {
    'tzachar/highlight-undo.nvim',
    opts = {
      ignored_filetypes = {
        'neo-tree',
        'fugitive',
        'TelescopePrompt',
        'mason',
        'lazy',
        'netrw',
        'tutor',
        'snacks_dashboard',
        'snacks_terminal',
      },
    },
  },
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      filetype_exclude = {
        'netrw',
        'tutor',
        'snacks_dashboard',
        'snacks_terminal',
      },
    },
  },
  {
    'Wansmer/treesj',
    opts = {
      ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
      use_default_keymaps = false,
    },
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local treesj = require('treesj')

      keys = {
        {
          '<leader>i',
          treesj.split,
          desc = 'Split code block',
          mode = 'n',
        },
        {
          '<leader>j',
          treesj.join,
          desc = 'Join code block',
          mode = 'n',
        },
      }

      return keys
    end,
  },
  {
    'sustech-data/wildfire.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'zbirenbaum/neodim', ---@module 'neodim'
    ---@type neodim.Options
    opts = {
      hide = {
        underline = false,
        virtual_text = false,
        signs = false,
      },
    },
    event = 'LspAttach',
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = { snippetDir = os.getenv('HOME') .. '/MEGA' },
  },
  {
    'fei6409/log-highlight.nvim',
    opts = {},
  },
  {
    'nacro90/numb.nvim',
    opts = {},
  },
}
