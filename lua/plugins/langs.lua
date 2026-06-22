---@diagnostic disable: missing-fields
---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'yousefhadder/markdown-plus.nvim',
    ft = 'markdown',
    opts = {},
  },
  {
    'GCBallesteros/jupytext.nvim',
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'md',
          style = 'markdown',
          force_ft = 'markdown', -- you can set whatever filetype you want here
        },
      },
    },
  },
  {
    'linux-cultist/venv-selector.nvim', ---@module 'venv-selector'
    ---@type venv-selector.Settings
    opts = {
      options = {
        notify_user_on_venv_activation = true,
      },
    },
    ft = 'python',
    cmd = 'VenvSelect',
    --  Call config for Python files and load the cached venv automatically
    keys = {
      {
        '<leader>cv',
        function()
          vim.cmd('VenvSelect')
        end,
        desc = 'Select VirtualEnv',
        mode = 'n',
        ft = 'python',
      },
    },
  },
}
