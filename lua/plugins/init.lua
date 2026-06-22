--- @diagnostic disable: missing-fields, type-not-found, annotation-usage-error
---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  -- Plugins with configs go here
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
            refactoring.select_refactor({})
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
            return refactoring.inline_var({})
          end,
          desc = 'Inline Variable',
          mode = modes,
          expr = true,
        },
        {
          '<leader>ref',
          function()
            return refactoring.inline_func({})
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
            return refactoring.extract_var({})
          end,
          desc = 'Extract Variable',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rxf',
          function()
            return refactoring.extract_func({})
          end,
          desc = 'Extract Function',
          mode = modes,
          expr = true,
        },
        {
          '<leader>rxF',
          function()
            return refactoring.extract_func_to_file({})
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
    'chrisgrieser/nvim-recorder', ---@module 'recorder'
    ---@type configObj
    opts = {
      mapping = {
        startStopRecording = 'qq',
        switchSlot = '<A-q>',
        editMacro = 'qc',
        deleteAllMacros = 'qd',
      },
    },
    keys = {
      {
        'q',
        '',
        desc = '+macros',
        mode = 'n',
      },
    },
    -- ,dependencies = 'rcarriga/nvim-notify'
  },
  {
    'hiphish/rainbow-delimiters.nvim', ---@module 'rainbow-delimiters'
    ---@type rainbow_delimiters.config
    opts = {
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterOrange',
        'RainbowDelimiterYellow',
        'RainbowDelimiterLightGreen',
        'RainbowDelimiterGreen',
        'RainbowDelimiterBlue',
        'RainbowDelimiterCyan',
        'RainbowDelimiterViolet',
      },
    },
    main = 'rainbow-delimiters.setup',
  },
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
    'romus204/tree-sitter-manager.nvim',
    opts = {
      border = 'rounded',
    },
  },
  {
    'Sang-it/fluoride',
    opts = {
      window = { border = 'rounded' },
    },
  },
  {
    'yousefhadder/markdown-plus.nvim',
    ft = 'markdown',
    opts = {},
  },
  {
    'auipga/hmts.nvim',
    branch = 'patch-1',
  },
  {
    'nanotee/zoxide.vim',
    init = function()
      vim.g.zoxide_use_select = 1
    end,
  },
  {
    'Mgenuit/nvim-dap-kotlin',
    opts = {},
  },
  {
    'leoluz/nvim-dap-go',
    opts = {},
  },
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('debugpy-adapter', {})
    end,
    ft = 'python',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local dap_py = require('dap-python')
      keys = {
        {
          '<leader>dy',
          '',
          desc = '+Dap Python',
          mode = 'n',
        },
        {
          '<leader>dyt',
          dap_py.test_method,
          desc = 'Debug Method',
          mode = 'n',
          -- expr = true,
          ft = 'python',
        },
        {
          '<leader>dyc',
          dap_py.test_class,
          desc = 'Debug Class',
          mode = 'n',
          -- expr = true,
          ft = 'python',
        },
      }

      return keys
    end,
  },
  {
    'fei6409/log-highlight.nvim',
    opts = {},
  },
  {
    'AckslD/muren.nvim',
    opts = {},
  },
  {
    'nvzone/volt',
    lazy = true,
  },
  {
    'kevinhwang91/nvim-hlslens',
    opts = {},
  },
  {
    'nvzone/showkeys',
    cmd = 'ShowkeysToggle',
    opts = { position = 'bottom-center' },
  },
  {
    'nvzone/minty',
    cmd = { 'Shades', 'Heufy' },
    opts = {},
  },
  {
    'abccsss/nvim-gitstatus',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    opts = {},
    event = 'VeryLazy',
    priority = 1000,
  },
  {
    'dgagn/diagflow.nvim',
    opts = {
      padding_right = 3,
      padding_top = 7,
      border_chars = {
        top_left = '╭',
        top_right = '╮',
        bottom_left = '╰',
        bottom_right = '╯',
      },
      show_borders = true,
    },
    event = 'LspAttach',
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
  },
  {
    'cbochs/portal.nvim',
    opts = {},
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = { snippetDir = os.getenv('HOME') .. '/MEGA' },
  },
  {
    'm-demare/hlargs.nvim',
    opts = {
      color = require('catppuccin.palettes').get_palette().red,
      hl_priority = 128,
    },
  },
  {
    'akinsho/toggleterm.nvim',
    opts = {},
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local function open_terminal()
        local tt = require('toggleterm')
        local terminals = require('toggleterm.terminal').get_all()
        if #terminals == 0 then
          tt.new(nil, LazyVim.root(), 'horizontal')
        else
          tt.toggle_all()
        end
      end

      local function create_terminal()
        local tt = require('toggleterm')
        local terminals = require('toggleterm.terminal').get_all()
        if #terminals ~= 0 then
          tt.new(nil, LazyVim.root(), 'horizontal')
        end
      end

      local function toggle_all_terminals()
        local tt = require('toggleterm')
        tt.toggle_all()
      end

      local function open_terminal_in_root()
        local tt = require('toggleterm')
        tt.new(nil, LazyVim.root(), 'horizontal')
      end

      local function open_terminal_in_cwd()
        local tt = require('toggleterm')
        tt.new(nil, vim.fn.getcwd(), 'horizontal')
      end

      keys = {
        {
          '<c-/>',
          open_terminal,
          desc = 'Open a Terminal (if one is not open)',
          mode = { 'n', 't' },
        },
        {
          '<c-\\>',
          create_terminal,
          desc = 'Create a new Terminal (if one is active)',
          mode = 'n',
        },
        {
          '<c-?>',
          toggle_all_terminals,
          desc = 'Toggles all Terminal instances',
        },
        {
          '<leader>ft',
          open_terminal_in_root,
          desc = 'Open a Terminal (Root Dir)',
          mode = 'n',
        },
        {
          '<leader>fT',
          open_terminal_in_cwd,
          desc = 'Open a Terminal (cwd)',
          mode = 'n',
        },
      }

      return keys
    end,
  },
  {
    'stevearc/stickybuf.nvim',
    opts = {},
  },
  {
    'ckolkey/ts-node-action',
    opts = {},
  },
  {
    'aaronik/treewalker.nvim',
    opts = {},
  },
  {
    'chentoast/marks.nvim',
    opts = function(_, opts)
      if not opts then
        return
      end

      opts.mappings = {
        set = 'mm',
        delete = 'md',
        delete_line = 'md-',
        delete_bookmark = 'md=',
        delete_buf = 'md<space>',
        -- set_next = "m,",
        -- next = "m]",
        -- preview = "m:",
        -- set_bookmark0 = "m0",
        -- prev = false
      }

      for i = 0, 9 do
        opts.mappings['set_bookmark' .. i] = 'm' .. tostring(i)
        opts.mappings['delete_bookmark' .. i] = 'md' .. tostring(i)
      end
    end,
    event = 'VeryLazy',
    keys = {
      {
        'm',
        '',
        desc = '+marks',
        mode = 'n',
      },
    },
  },
  {
    'sustech-data/wildfire.nvim',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'dstein64/nvim-scrollview',
    opts = {
      excluded_filetypes = { 'NvimTree' },
    },
  },
  {
    'vuki656/package-info.nvim',
    opts = {
      package_manager = 'bun',
    },
  },
  {
    'L3MON4D3/cmp-luasnip-choice',
    opts = {
      auto_open = true, -- Automatically open nvim-cmp on choice node (default: true)
    },
  },
  {
    'https://git.sr.ht/~havi/telescope-toggleterm.nvim',
    opts = {},
    event = 'TermOpen',
    dependencies = 'nvim-lua/popup.nvim',
  },
  {
    'jmbuhr/otter.nvim',
    opts = {},
  },
  {
    'windwp/nvim-autopairs',
    opts = { map_bs = false },
    event = 'InsertEnter',
  },
  {
    'DaikyXendo/nvim-material-icon',
    opts = {
      color_icons = true,
      default = true,
    },
  },
  {
    'xzbdmw/colorful-menu.nvim', ---@module 'colorful-menu'
    ---@type ColorfulMenuConfig
    opts = {
      max_width = 60,
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
    'nacro90/numb.nvim',
    opts = {},
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
    'mcauley-penney/visual-whitespace.nvim',
    opts = {
      list_chars = {
        tab = '│',
      },
    },
    event = 'ModeChanged *:[vV\22]',
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
    'mikavilpas/yazi.nvim', ---@module 'yazi'
    ---@type YaziConfig
    opts = {
      open_for_directories = true,
    },
    event = 'VeryLazy',
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local function open_at_current_file()
        local yz = require('yazi')
        yz.yazi(yz.config)
      end

      local function open_in_cwd()
        local yz = require('yazi')
        yz.yazi(yz.config, vim.fn.getcwd(), nil)
      end

      local function resume_last_session()
        local yz = require('yazi')
        yz.toggle(yz.config)
      end

      keys = {
        {
          '<leader>Y',
          open_at_current_file,
          desc = 'Open yazi at the current file',
          mode = 'n',
        },
        {
          '<leader>cw',
          open_in_cwd,
          desc = 'Open yazi in the cwd',
          mode = 'n',
        },
        {
          '<leader><up>',
          resume_last_session,
          desc = 'Resume the last yazi session',
          mode = 'n',
        },
      }

      return keys
    end,
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
    'Bekaboo/dropbar.nvim', ---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = {
          border = 'rounded',
        },
      },
    },
    lazy = false,
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      local dropbar_api = require('dropbar.api')

      keys = {
        {
          '<leader>;',
          dropbar_api.pick,
          desc = 'Pick symbols in winbar',
          mode = 'n',
        },
        {
          '[;',
          dropbar_api.goto_context_start,
          desc = 'Go to start of current context',
          mode = 'n',
        },
        {
          '];',
          dropbar_api.select_next_context,
          desc = 'Select next context',
          mode = 'n',
        },
      }

      return keys
    end,
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
    'michaelb/sniprun',
    opts = {},
    branch = 'master',
    build = 'sh ./install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
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
    '3rd/image.nvim', ---@module 'image'
    ---@type Options
    opts = {
      processor = 'magick_cli',
    },
    build = false,
  },
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = vim.fn.has('win32') and true or false,
      },
    },
    event = 'VeryLazy',
  },
  {
    'kylechui/nvim-surround', ---@module 'nvim-surround'
    ---@type user_options
    opts = {
      surrounds = {
        ['|'] = {
          add = { '|', '|' },
          delete = '^(.)().-(.)()$',
          label = '|...|',
        },
      },
    },
    version = '*',
    event = 'VeryLazy',
  },
  {
    'LunarVim/bigfile.nvim',
    --- @diagnostic disable-next-line: param-type-mismatch
    opts = {
      filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
      features = { -- features to disable
        'indent_blankline',
        'illuminate',
        'lsp',
        'treesitter',
        'syntax',
        'matchparen',
        'vimopts',
        'filetype',
      },
    },
  },
  {
    'nvim-tree/nvim-tree.lua', ---@module 'nvim-tree'
    ---@param opts nvim_tree.config?
    opts = function(_, opts)
      ---@param rel_path string
      ---@return string
      local function label(rel_path)
        rel_path = rel_path:gsub(tostring(os.getenv('HOME')), '~', 1)
        -- local a = path:gsub('([a-zA-Z])[a-z0-9]+', '%1')
        -- local b = tostring(path:match '[a-zA-Z]([a-z0-9]*)$' or '')
        return rel_path
      end

      local setEnable = { enable = true }

      if not opts then
        return
      end
      -- Has potential for a more complex configuration
      opts.sync_root_with_cwd = true
      opts.respect_buf_cwd = true
      opts.update_focused_file = {
        enable = true,
        update_root = setEnable,
      }
      opts.filters = setEnable
      opts.renderer = {
        icons = {
          glyphs = {
            git = {
              unstaged = '󰄱',
              staged = '󰱒',
            },
          },
        },
        root_folder_label = label,
        group_empty = label,
      }
    end,
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    deactivate = function()
      vim.cmd('NvimTreeClose')
    end,
    ---@param keys LazyKeysSpec[]|LazyKeys[]
    keys = function(_, keys)
      -- Open nvim-tree at root
      local function open_at_root()
        local api = require('nvim-tree.api')
        api.tree.toggle({ path = LazyVim.root() })
      end

      -- Open nvim-tree at CWD
      local function open_at_cwd()
        local api = require('nvim-tree.api')
        api.tree.toggle({ path = vim.fn.getcwd() })
      end

      -- Change root to CWD for nvim-tree
      local function change_root_to_global_cwd()
        local api = require('nvim-tree.api')
        local global_cwd = vim.fn.getcwd(-1, -1)
        api.tree.change_root(global_cwd)
      end

      -- Focus on currently opened file in nvim-tree
      local function find_opened_file()
        local api = require('nvim-tree.api')
        api.tree.find_file({ update_root = false, open = true, focus = true })
      end

      keys = {
        {
          '<leader>e',
          open_at_root,
          desc = 'nvim-tree: Explorer nvim-tree (root)',
          mode = 'n',
        },
        {
          '<leader>E',
          open_at_cwd,
          desc = 'nvim-tree: Explorer nvim-tree (cwd)',
          mode = 'n',
        },
        {
          '<leader>fe',
          open_at_root,
          desc = 'nvim-tree: Explorer nvim-tree (root)',
          mode = 'n',
        },
        {
          '<leader>fE',
          open_at_cwd,
          desc = 'nvim-tree: Explorer nvim-tree (cwd)',
          mode = 'n',
        },
        {
          '<leader>fC',
          change_root_to_global_cwd,
          desc = 'nvim-tree: Change root to global cwd (nvim-tree)',
          mode = 'n',
        },
        {
          '<leader>fd',
          find_opened_file,
          desc = 'nvim-tree: Focus on currently opened file',
          mode = 'n',
        },
      }

      return keys
    end,
  },
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
