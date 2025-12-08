-- bootstrap lazy.nvim, LazyVim and your plugins
require('config.lazy')


-- Set the theme to Catpuccin Macchiato
vim.cmd.colorscheme('catppuccin-macchiato')


--- none-ls.nvim
do
  local null_ls = require('null-ls')
  ---@module 'null-ls.builtins._meta.code_actions'
  local null_ls__code_actions = null_ls.builtins.code_actions
  ---@module 'null-ls.builtins._meta.completion'
  local null_ls__completion = null_ls.builtins.completion
  ---@module 'null-ls.builtins._meta.diagnostics'
  local null_ls__diagnostics = null_ls.builtins.diagnostics
  ---@module 'null-ls.builtins._meta.formatting'
  local null_ls__formatting = null_ls.builtins.formatting
  local null_ls_sources = null_ls.get_sources()
  -- ---@module 'null-ls.builtins._meta.hover'
  -- local null_ls__hover = null_ls.builtins.hover

  local new_null_ls_sources = {
    null_ls__code_actions.gitsigns,
    null_ls__code_actions.refactoring,
    null_ls__code_actions.statix,
    null_ls__completion.luasnip,
    null_ls__completion.tags,
    null_ls__diagnostics.actionlint,
    null_ls__diagnostics.deadnix,
    null_ls__diagnostics.dotenv_linter,
    null_ls__diagnostics.editorconfig_checker,
    null_ls__diagnostics.fish,
    null_ls__diagnostics.ktlint,
    null_ls__diagnostics.markdownlint,
    null_ls__diagnostics.markdownlint_cli2,
    null_ls__diagnostics.rpmspec,
    null_ls__diagnostics.todo_comments,
    null_ls__diagnostics.trail_space,
    null_ls__diagnostics.statix,
    null_ls__diagnostics.selene,
    null_ls__diagnostics.pydoclint,
    null_ls__diagnostics.yamllint,
    null_ls__formatting.alejandra,
    null_ls__formatting.biome,
    null_ls__formatting.prettier,
    null_ls__formatting.fish_indent,
    null_ls__formatting.gofumpt,
    null_ls__formatting.markdownlint,
    null_ls__formatting.shfmt,
    require('none-ls.formatting.ruff'),
    require('none-ls.formatting.tex_fmt'),
    null_ls__formatting.uncrustify,
    null_ls__formatting.yamlfmt
  }

  for _, source in ipairs(new_null_ls_sources) do
    table.insert(null_ls_sources, source)
  end

  null_ls.setup {
    sources = null_ls_sources
  }
end



-- conform.nvim
-- require('conform').setup {
--   formatters_by_ft = {
--     javascript = { 'prettier', 'prettierd', stop_after_first = true },
--     typescript = { 'prettier', 'prettierd', stop_after_first = true }
--   }
-- }


-- indent-blankline
do
  local highlight = {
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
    vim.api.nvim_set_hl(0, highlight[1], { fg = '#ed6e6d' })
    vim.api.nvim_set_hl(0, highlight[2], { fg = '#ef7734' })
    vim.api.nvim_set_hl(0, highlight[3], { fg = '#e2b65e' })
    vim.api.nvim_set_hl(0, highlight[4], { fg = '#72d35d' })
    vim.api.nvim_set_hl(0, highlight[5], { fg = '#009b00' })
    vim.api.nvim_set_hl(0, highlight[6], { fg = '#3f78ec' })
    vim.api.nvim_set_hl(0, highlight[7], { fg = '#7dc4e4' })
    vim.api.nvim_set_hl(0, highlight[8], { fg = '#9c5aef' })
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
end


-- rainbow-delimiters
do
  local highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterOrange',
    'RainbowDelimiterYellow',
    'RainbowDelimiterLightGreen',
    'RainbowDelimiterGreen',
    'RainbowDelimiterBlue',
    'RainbowDelimiterCyan',
    'RainbowDelimiterViolet'
  }

  vim.api.nvim_set_hl(0, highlight[1], { fg = '#ed6e6d' })
  vim.api.nvim_set_hl(0, highlight[2], { fg = '#ef7734' })
  vim.api.nvim_set_hl(0, highlight[3], { fg = '#e2b65e' })
  vim.api.nvim_set_hl(0, highlight[4], { fg = '#72d35d' })
  vim.api.nvim_set_hl(0, highlight[5], { fg = '#009b00' })
  vim.api.nvim_set_hl(0, highlight[6], { fg = '#3f78ec' })
  vim.api.nvim_set_hl(0, highlight[7], { fg = '#7dc4e4' })
  vim.api.nvim_set_hl(0, highlight[8], { fg = '#9c5aef' })

  vim.g.rainbow_delimiters = { highlight = highlight }
end


-- harper:ignore
-- trim.nvim
require('trim').setup {
  -- harper:ignore
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  ft_blocklist = {
    'ruby',
    'lua',
    'fish',
    'sh',
    'bash',
    'csharp',
    'snacks_dashboard',
    'snacks_terminal'
  },
  -- harper:ignore
  -- if you want to disable trim on write by default
  trim_on_write = false,
  -- highlight trailing spaces
  highlight = true
}


-- -- nvim-snippets
-- require('snippets').setup {
--   search_paths = {  os.getenv('HOME') .. '/MEGA' }
-- }


-- LuaSnip
require('luasnip.loaders.from_vscode').lazy_load {
  paths = { os.getenv('HOME') .. '/MEGA' }
}


-- telescope extensions
do
  local telescope = require('telescope')

  local telescope_plugins = {
    'ui-select',
    'undo',
    'frecency',
    'dap',
    'scope'
  }

  for _, plugin in ipairs(telescope_plugins) do
    telescope.load_extension(plugin)
  end
end

--- nvim-cmp
do
  local cmp = require('cmp')
  local cmp_config = cmp.get_config()

  ---@type cmp.SourceConfig[]
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

  for _, source in ipairs(cmp_sources) do
    table.insert(cmp_config.sources, source)
  end

  cmp.setup {
    window = {
      completion = {
        border = 'rounded'
      },
      ---@diagnostic disable-next-line: missing-fields
      documentation = {
        border = 'rounded'
      }
    },
    formatting = {
      fields = { 'abbr', 'kind', 'menu' },
      format = function(entry, vim_item)
        local lspkind = require('lspkind').cmp_format { mode = 'symbol_text' }
        local extra_opts = lspkind(entry, vim.deepcopy(vim_item))
        local highlights_info = require('colorful-menu').cmp_highlights(entry)

        -- highlight_info is nil means we are missing the ts parser, it's
        -- better to fallback to use default `vim_item.abbr`. What this plugin
        -- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
        if highlights_info ~= nil then
          vim_item.abbr_hl_group = highlights_info.highlights
          vim_item.abbr = highlights_info.text
        end

        local strings = vim.split(extra_opts.kind, '%s', { trimempty = true })
        vim_item.kind = ' ' .. (strings[1] or '') .. ' '
        vim_item.menu = ''

        return vim_item
      end
    },
    sources = cmp_config.sources,
    -- mapping = cmp.mapping.preset.insert {
    --   ['<a-y>'] = require('minuet').make_cmp_map()
    -- },
    ---@diagnostic disable-next-line: missing-fields
    performance = {
      fetching_timeout = 2000
    }
  }

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
end


-- Keep everything else from mini.animate except the cursor animation.
do
  local mini_ani__exists, mod = pcall(require, 'mini.animate')
  if mini_ani__exists then mod.config.cursor.enable = false end
end


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
do
  vim.api.nvim_create_user_command('M', 'MurenToggle', {
    desc = 'Toggle Muren', bang = true, register = true, range = 0
  })

  --- @diagnostic disable-next-line: param-type-mismatch
  vim.api.nvim_create_user_command('LspInfoPicker', Snacks.picker.lsp_config, {
    desc = 'Show lsp info', bang = true, register = true, range = 0, force = true
  })
end
