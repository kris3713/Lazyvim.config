---@diagnostic disable: missing-fields
---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  {
    'rachartier/tiny-code-action.nvim',
    opts = {
      ---The backend to use, currently only 'vim', 'delta', 'difftastic', 'diffsofancy' are supported
      ---@type 'vim'|'delta'|'difftastic'|'diffsofancy'
      backend = 'delta',

      ---The picker to use, 'telescope', 'snacks', 'select', 'buffer', 'fzf-lua' are supported
      ---And it's opts that will be passed at the picker's creation, optional
      ---
      ---You can also set `picker = '<picker>'` without any opts.
      ---@type 'telescope'|'snacks'|'select'|'buffer'|'fzf-lua'
      picker = 'snacks',
    },
    event = 'LspAttach',
  },
  {
    'luckasRanarison/tailwind-tools.nvim', ---@module 'tailwind-tools'
    ---@type TailwindTools.Option
    opts = {
      server = {
        settings = {
          experimental = {
            classRegex = {
              {
                'classnames\\(([^)]*)\\)',
                '\'([^\']*)\'',
              },
              {
                'classList={{([^;]*)}}',
                '\\s*?["\'`]([^"\'`]*).*?:',
              },
              {
                'classNames:\\s*{([\\s\\S]*?)}',
                '\\s?[\\w].*:\\s*?["\'`]([^"\'`]*).*?,?\\s?',
              },
              'class:\\s*[\'\\"]([^\'\\"]*)[\'\\"]',
              ':class=\\s*\\{([^}]+)\\}',
              '(?:enter|leave)(?:From|To)?=\\s*(?:"|\'|{`)([^(?:"|\'|`})]*)',
              'tw`([^`]*)`',
              'tw="([^"]*)', -- <div tw="..." />
              'tw={"([^"}]*)', -- <div tw={"..."} />
              'tw\\.\\w+`([^`]*)', -- tw.xxx`...`
              'tw\\(.*?\\)`([^`]*)', -- tw(Component)`...`
            },
          },
          includeLanguages = {
            elixir = 'html-eex',
            eelixir = 'html-eex',
            heex = 'html-eex',
          },
        },
      },
    },
    name = 'tailwind-tools',
    build = function()
      vim.cmd('UpdateRemotePlugins')
    end,
  },
  {
    'nvimdev/lspsaga.nvim', ---@module 'lspsaga'
    ---@type LspsagaConfig
    opts = {
      ui = { code_action = '' },
      symbol_in_winbar = { enable = false },
    },
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    opts = {},
  },
  {
    'ray-x/lsp_signature.nvim',
    opts = {
      handler_opts = { border = 'rounded' },
      hint_prefix = '❔ ',
      floating_window_off_y = 15,
    },
    event = 'InsertEnter',
  },
  {
    'gbprod/phpactor.nvim',
    ft = 'php',
    opts = {
      install = {
        path = vim.fn.stdpath('data') .. '/mason/bin',
        bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor',
      },
    },
  },
  {
    'seblyng/roslyn.nvim', ---@module 'roslyn'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = 'roslyn',
    },
    ft = { 'cs' },
  },
  {
    'jmbuhr/otter.nvim',
    opts = {},
  },
}
