-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- none-ls.nvim
local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.completion.nvim_snippets,
    null_ls.builtins.completion.tags,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.checkstyle.with {
      extra_args = { '-c', vim.uv.os_homedir() .. '/MEGA/checkstyle.xml' }
    },
    null_ls.builtins.diagnostics.dotenv_linter,
    null_ls.builtins.diagnostics.editorconfig_checker,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.markdownlint,
    null_ls.builtins.diagnostics.rpmspec,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.sqlfluff.with {
      extra_args = { '--dialect', 'postgres' }
    },
    null_ls.builtins.diagnostics.pydoclint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.sqlfluff.with {
      extra_args = { '--dialect', 'postgres' }
    },
    null_ls.builtins.formatting.uncrustify,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.hover.printenv
  }
}

-- nlsp-settings.nvim
local nlspsettings = require('nlspsettings')

nlspsettings.setup({
  config_home = vim.fn.stdpath('config') .. '/nlsp-settings',
  local_settings_dir = '.nlsp-settings',
  local_settings_root_markers_fallback = { '.git' },
  append_default_schemas = true,
  loader = 'json'
})

-- conform.nvim
-- require('conform').setup {
--   formatters_by_ft = {
--     javascript = { 'prettier', 'prettierd', stop_after_first = true },
--     typescript = { 'prettier', 'prettierd', stop_after_first = true }
--   }
-- }

-- rainbow-delimiters and
-- indent-blankline
local highlight = {
  'RainbowRed',
  'RainbowOrange',
  'RainbowYellow',
  'RainbowGreen',
  'RainbowBlue',
  'RainbowCyan',
  'RainbowViolet'
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#ed6e6d' })
  vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#ef7734' })
  vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#e2b65e' })
  vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#72d35d' })
  vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#3f78ec' })
  vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#c6a0f6' })
end)

require('ibl').setup {
  indent = {
    smart_indent_cap = true,
    char = '│',
    highlight = highlight,
    tab_char = '│'
  },
  scope = { show_start = true, show_end = true }
}

-- rainbow-delimiters
-- This module contains a number of default definitions
local delimiter_highlight = {
  'RainbowDelimiterRed',
  'RainbowDelimiterOrange',
  'RainbowDelimiterYellow',
  'RainbowDelimiterGreen',
  'RainbowDelimiterBlue',
  'RainbowDelimiterCyan',
  'RainbowDelimiterViolet'
}

vim.api.nvim_set_hl(0, 'RainbowDelimiterRed', { fg = '#ed6e6d' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterOrange', { fg = '#ef7734' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterYellow', { fg = '#e2b65e' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterGreen', { fg = '#72d35d' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterBlue', { fg = '#3f78ec' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterCyan', { fg = '#7dc4e4' })
vim.api.nvim_set_hl(0, 'RainbowDelimiterViolet', { fg = '#c6a0f6' })

vim.g.rainbow_delimiters = { highlight = delimiter_highlight }

require('trim').setup {
  -- harper:ignore
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {
    'ruby', 'lua', 'fish', 'sh', 'bash', 'csharp'
  },
  -- harper:ignore
  -- if you want to disable trim on write by default
  trim_on_write = false,
  -- highlight trailing spaces
  highlight = true
}

-- Keep everything else from mini.animate except the cursor animation.
local mini_ani_exists, mod = pcall(require, 'mini.animate')
if mini_ani_exists then mod.config.cursor.enable = false end

-- nvim-snippets
require('snippets').setup {
  search_paths = { vim.uv.os_homedir() .. '/MEGA' }
}

-- lualine.nvim
require('lualine').setup {
  sections = {
    lualine_c = {
      {
        'diagnostics',
        on_click = function(clicks, _, _)
          if clicks == 2 then
            require('trouble').toggle {
              mode = 'diagnostics',
              filter = { buf = vim.api.nvim_get_current_buf() }
            }
          end
        end
      },
      -- {
      --   'lsp_status',
      --   ---@param clicks number
      --   on_click = function(clicks, _, _)
      --     if clicks == 2 then require('snacks').picker.lsp_config() end
      --   end,
      -- }
    },
    lualine_x = {
      { 'encoding', show_bomb = true },
      {
        -- indent_style
        function()
          if vim.bo.expandtab then
            return 'Spaces'
          else
            return 'Tabs'
          end
        end
      },
      {
        -- shiftwidth/tabstop
        function()
          if vim.bo.expandtab then
            return ('Indent Size: ' .. vim.bo.shiftwidth)
          else
            return ('Tab Width: ' .. vim.bo.tabstop)
          end
        end,
        ---@param clicks any
        on_click = function(clicks, _, _)
          if clicks == 2 then
            require('functions.set_shiftwidth_prompt').set_shiftwidth_prompt()
          end
        end
      },
      {
        -- fileformat
        function()
          if vim.bo.fileformat == 'unix' then
            return 'LF (unix)'
          elseif vim.bo.fileformat == 'dos' then
            return 'CRLF (dos)'
          elseif vim.bo.fileformat == 'mac' then
            return 'CR (mac)'
          else
            return vim.bo.fileformat
          end
        end,
        ---@param clicks number
        on_click = function(clicks, _, _)
          if clicks == 2 then
            if vim.bo.fileformat == 'unix' then
              vim.bo.fileformat = 'dos'
            elseif vim.bo.fileformat == 'dos' then
              vim.bo.fileformat = 'mac'
            elseif vim.bo.fileformat == 'mac' then
              vim.bo.fileformat = 'unix'
            end
          end
        end
      },
      {
        'filetype',
        on_click = function(clicks, _, _)
          if clicks == 2 then require('telescope.builtin').filetypes() end
        end
      }
    },
    lualine_y = { 'searchcount', 'selectioncount', 'progress' },
    lualine_z = { 'location' }
  }
}

-- telescope extensions
local telescope = require('telescope')

telescope.load_extension('ui-select')
telescope.load_extension('undo')
telescope.load_extension('frecency')
telescope.load_extension('dap')
telescope.load_extension('scope')

-- nvim-cmp
local cmp = require('cmp')
local cmp_config = cmp.get_config()

---@type cmp.SourceConfig
local new_sources = {
  { name = 'nvim_lsp_signature_help' },
  { name = 'dap' },
  { name = 'render-markdown' }
}

for _, i in ipairs(new_sources) do
  table.insert(cmp_config.sources, i)
end

---@type cmp.ConfigSchema
local cmp_setup = {
  window = {
    completion = {
      border = 'rounded'
    },
    documentation = {
      border = 'rounded'
    }
  },
  formatting = { format = require('lspkind').cmp_format {} },
  sources = cmp_config.sources
}

cmp.setup(cmp_setup)

-- mouse menu
vim.cmd.aunmenu('PopUp.How-to\\ disable\\ mouse')

for _, mode in ipairs({'n', 'x'}) do
  -- Modified built-in entries
  vim.cmd(string.format(
    [[ %smenu PopUp.Go\ to\ definition gd ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Diagnostics <leader>cd ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]], mode
  ))
  -- vim.cmd(string.format(
  --   [[ %sunmenu PopUp.Configure\ Diagnostics ]], mode
  -- ))

  -- Implement a code actions entry
  vim.cmd(string.format(
    [[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]], mode
  ))

  -- Implement all go-to definitions
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ References gr ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Implementation gI ]], mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Type\ Definition gy ]], mode
  ))
end

-- User commands
vim.api.nvim_create_user_command('M', 'MurenToggle', {
  desc = 'Toggle Muren', bang = true, register = true, range = 0
})
