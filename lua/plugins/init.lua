--- @diagnostic disable: missing-fields
---@module 'lazy'

return  --[[@type (LazyPluginSpec[])]]{
  -- Plugins with configs go here
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
    'Sang-it/fluoride',
    opts = {
      window = { border = 'rounded' },
    },
  },
  {
    'nanotee/zoxide.vim',
    init = function()
      vim.g.zoxide_use_select = 1
    end,
  },
  {
    'AckslD/muren.nvim',
    opts = {},
  },
  {
    'b0o/SchemaStore.nvim',
    lazy = true,
    version = false, -- last release is way too old
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
    'nacro90/numb.nvim',
    opts = {},
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
    'michaelb/sniprun',
    opts = {},
    branch = 'master',
    build = 'sh ./install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
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
}
