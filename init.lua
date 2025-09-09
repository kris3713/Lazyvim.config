-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')

-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')

--- none-ls.nvim
local null_ls = require('null-ls')
local null_ls_sources = null_ls.get_sources()

local new_null_ls_sources = {
  null_ls.builtins.code_actions.gitsigns,
  null_ls.builtins.code_actions.refactoring,
  -- null_ls.builtins.completion.nvim_snippets,
  null_ls.builtins.completion.luasnip,
  null_ls.builtins.completion.tags,
  null_ls.builtins.completion.spell,
  null_ls.builtins.diagnostics.actionlint,
  null_ls.builtins.diagnostics.checkstyle.with {
    extra_args = { '-c', os.getenv('HOME') .. '/MEGA/checkstyle.xml' }
  },
  null_ls.builtins.diagnostics.deadnix,
  null_ls.builtins.diagnostics.dotenv_linter,
  null_ls.builtins.diagnostics.editorconfig_checker,
  null_ls.builtins.diagnostics.fish,
  null_ls.builtins.diagnostics.ktlint,
  null_ls.builtins.diagnostics.markdownlint,
  null_ls.builtins.diagnostics.markdownlint_cli2,
  null_ls.builtins.diagnostics.rpmspec,
  null_ls.builtins.diagnostics.todo_comments,
  null_ls.builtins.diagnostics.trail_space,
  null_ls.builtins.diagnostics.pydoclint,
  null_ls.builtins.diagnostics.yamllint,
  null_ls.builtins.formatting.alejandra,
  null_ls.builtins.formatting.biome,
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.fish_indent,
  null_ls.builtins.formatting.gofumpt,
  null_ls.builtins.formatting.markdownlint,
  require('none-ls.formatting.ruff'),
  null_ls.builtins.formatting.shfmt,
  require('none-ls.formatting.tex_fmt'),
  null_ls.builtins.formatting.uncrustify,
  null_ls.builtins.formatting.yamlfmt,
  null_ls.builtins.hover.dictionary,
  null_ls.builtins.hover.printenv
}

for _, value in ipairs(new_null_ls_sources) do
  table.insert(null_ls_sources, value)
end

null_ls.setup {
  sources = null_ls_sources
}

-- nlsp-settings.nvim
require('nlspsettings').setup({
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
local indent_highlight = {
  'RainbowRed',
  'RainbowOrange',
  'RainbowYellow',
  'RainbowLightGreen',
  'RainbowGreen',
  'RainbowBlue',
  'RainbowCyan',
  'RainbowViolet'
}

local hooks = require('ibl.hooks')
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, indent_highlight[1], { fg = '#ed6e6d' })
  vim.api.nvim_set_hl(0, indent_highlight[2], { fg = '#ef7734' })
  vim.api.nvim_set_hl(0, indent_highlight[3], { fg = '#e2b65e' })
  vim.api.nvim_set_hl(0, indent_highlight[4], { fg = '#72d35d' })
  vim.api.nvim_set_hl(0, indent_highlight[5], { fg = '#009b00' })
  vim.api.nvim_set_hl(0, indent_highlight[6], { fg = '#3f78ec' })
  vim.api.nvim_set_hl(0, indent_highlight[7], { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, indent_highlight[8], { fg = '#9c5aef' })
end)

require('ibl').setup {
  indent = {
    smart_indent_cap = true,
    char = '│',
    highlight = indent_highlight,
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
  'RainbowDelimiterLightGreen',
  'RainbowDelimiterGreen',
  'RainbowDelimiterBlue',
  'RainbowDelimiterCyan',
  'RainbowDelimiterViolet'
}

vim.api.nvim_set_hl(0, delimiter_highlight[1], { fg = '#ed6e6d' })
vim.api.nvim_set_hl(0, delimiter_highlight[2], { fg = '#ef7734' })
vim.api.nvim_set_hl(0, delimiter_highlight[3], { fg = '#e2b65e' })
vim.api.nvim_set_hl(0, delimiter_highlight[4], { fg = '#72d35d' })
vim.api.nvim_set_hl(0, delimiter_highlight[5], { fg = '#009b00' })
vim.api.nvim_set_hl(0, delimiter_highlight[6], { fg = '#3f78ec' })
vim.api.nvim_set_hl(0, delimiter_highlight[7], { fg = '#7dc4e4' })
vim.api.nvim_set_hl(0, delimiter_highlight[8], { fg = '#9c5aef' })

vim.g.rainbow_delimiters = { highlight = delimiter_highlight }

require('trim').setup {
  -- harper:ignore
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {
    'ruby', 'lua', 'fish', 'sh', 'bash', 'csharp', 'snacks_dashboard', 'snacks_terminal'
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

-- -- nvim-snippets
-- require('snippets').setup {
--   search_paths = {  os.getenv('HOME') .. '/MEGA' }
-- }

-- LuaSnip
require('luasnip.loaders.from_vscode').lazy_load {
  paths = { os.getenv('HOME') .. '/MEGA' }
}

-- telescope extensions
local telescope = require('telescope')

for _, i in ipairs { 'ui-select','undo', 'frecency', 'dap', 'scope' } do
  telescope.load_extension(i)
end

--- nvim-cmp
local cmp = require('cmp')
local cmp_config = cmp.get_config()

---@type cmp.SourceConfig
local cmp_sources = {
  { name = 'nvim_lsp_signature_help' },
  { name = 'nvim_lua' },
  { name = 'dap' },
  { name = 'render-markdown' },
  { name = 'diag-codes' },
  { name = 'luasnip_choice' },
  { name = 'npm' },
  { name = 'pypi' }
}

for _, i in ipairs(cmp_sources) do
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
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },
    format = function(entry, vim_item)
      local kind = (require('lspkind').cmp_format {
        mode = 'symbol_text'
      })(entry, vim.deepcopy(vim_item))
      local highlights_info = require('colorful-menu').cmp_highlights(entry)

      -- highlight_info is nil means we are missing the ts parser, it's
      -- better to fallback to use default `vim_item.abbr`. What this plugin
      -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
      if highlights_info ~= nil then
        vim_item.abbr_hl_group = highlights_info.highlights
        vim_item.abbr = highlights_info.text
      end

      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      vim_item.kind = ' ' .. (strings[1] or '') .. ' '
      vim_item.menu = ''

      return vim_item
    end
  },
  sources = cmp_config.sources,
  -- mapping = cmp.mapping.preset.insert {
  --   ['<a-y>'] = require('minuet').make_cmp_map()
  -- },
  performance = {
    fetching_timeout = 2000
  }
}

cmp.setup(cmp_setup)

-- only for sql
cmp.setup.filetype('sql', {
  sources = {
    { name = 'sql' }
  }
})

-- only for golang
cmp.setup.filetype('go', {
  sources = {
    { name = 'go_pkgs' },
    {
      name = 'go_deep',
      keyword_length = 3,
      max_item_count = 5,
      ---@module 'cmp_go_deep'
      ---@type cmp_go_deep.Options
      option = {}
    }
  }
})

-- mouse menu
vim.cmd.aunmenu('PopUp.How-to\\ disable\\ mouse')

for _, mode in ipairs { 'n', 'x' } do
  -- Modified built-in entries
  vim.cmd(string.format(
    [[ %smenu PopUp.Go\ to\ definition gd ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Diagnostics <leader>cd ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ All\ Diagnostics <leader>xX ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Configure\ Diagnostics <Nop> ]],
    mode
  ))

  -- Implement a code actions entry
  vim.cmd(string.format(
    [[ %smenu PopUp.Open\ Code\ Actions <leader>ca ]],
    mode
  ))

  -- Implement all go-to definitions
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ References gr ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Implementation gI ]],
    mode
  ))
  vim.cmd(string.format(
    [[ %smenu PopUp.Show\ Type\ Definition gy ]],
    mode
  ))
end

-- User commands
vim.api.nvim_create_user_command('M', 'MurenToggle', {
  desc = 'Toggle Muren', bang = true, register = true, range = 0
})

vim.api.nvim_create_user_command('LspInfoPicker', Snacks.picker.lsp_config, {
  desc = 'Show lsp info', bang = true, register = true, range = 0, force = true
})
