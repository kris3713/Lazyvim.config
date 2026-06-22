---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'rmagatti/auto-session', ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true,
      },
      lazy_support = true,
      lsp_stop_on_restore = true,
      suppressed_dirs = { os.getenv('HOME'), '/' },
      continue_restore_on_error = false,
      cwd_change_handling = true,
      pre_restore_cmds = {
        function()
          ---@param name string
          ---@return integer
          local function create_augroup(name)
            return vim.api.nvim_create_augroup(name, { clear = true })
          end

          local create_autocmd = vim.api.nvim_create_autocmd

          -- Enforce Unix-style line endings for all files
          create_autocmd({ 'BufEnter', 'BufRead', 'WinEnter' }, {
            group = create_augroup('change_line_ending'),
            desc = 'Ensure that all files have Unix-style line endings',
            pattern = '*',
            callback = function()
              local bufnr = vim.api.nvim_get_current_buf()
              local is_true = (vim.bo[bufnr].filetype ~= 'help')
                or (vim.bo[bufnr].filetype ~= 'man')
                or (vim.bo[bufnr].filetype ~= 'gitcommit')

              if is_true and vim.bo[bufnr].modifiable then
                vim.o.fileformats = 'unix,dos,mac'
              end
            end,
          })
        end,
      },
    },
    lazy = false,
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local function save_session()
        local auto = require('auto-session')
        auto.save_session(vim.fn.getcwd())
      end

      local function restore_session()
        local auto = require('auto-session')
        auto.restore_session(vim.fn.getcwd())
      end

      keys = {
        {
          '<leader>qf',
          function()
            vim.cmd('AutoSession search')
          end,
          desc = 'Select a session to load/delete',
          mode = 'n',
        },
        {
          '<leader>qS',
          save_session,
          desc = 'Save session based on cwd',
          mode = 'n',
        },
        {
          '<leader>qs',
          restore_session,
          desc = 'Restore last session based on cwd',
          mode = 'n',
        },
        {
          '<leader>qd',
          function()
            vim.cmd('AutoSession toggle')
          end,
          desc = 'Toggle autosave',
          mode = 'n',
        },
      }

      return keys
    end,
  },
}
