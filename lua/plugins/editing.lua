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
}
