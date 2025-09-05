return {
  -- Plugins with configs go here
  -- {
  --   'LazyVim/LazyVim',
  --   url = 'https://github.com/LazyVim/LazyVim',
  --   branch = 'main'
  -- },
  {
    'nanotee/zoxide.vim',
    init = function() vim.g.zoxide_use_select = 1 end
  },
  {
    'Mgenuit/nvim-dap-kotlin',
    config = true
  },
  {
    'fei6409/log-highlight.nvim',
    config = true
  },
  {
    'samiulsami/cmp-go-deep',
    dependencies = 'kkharji/sqlite.lua'
  },
  {
    'AckslD/muren.nvim',
    config = true
  },
  {
    'nvzone/volt',
    lazy = true
  },
  {
    'kevinhwang91/nvim-hlslens',
    config = true
  },
  {
    'lewis6991/satellite.nvim',
    config = true
  },
  {
    'nvzone/minty',
    config = true,
    cmd = { 'Shades', 'Heufy' }
  },
  {
    'abccsss/nvim-gitstatus',
    event = 'VeryLazy',
    config = true
  },
  {
    'chrisgrieser/nvim-scissors',
    opts = {
      snippetDir =  os.getenv('HOME') .. '/MEGA',
    }
  },
  {
    'm-demare/hlargs.nvim',
    opts = {
      color = '#ed8796'
    }
  },
  {
    'L3MON4D3/cmp-luasnip-choice',
    opts = {
      auto_open = true -- Automatically open nvim-cmp on choice node (default: true)
    }
  },
  {
    'jmbuhr/otter.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('otter').setup {}
    end
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      -- Has potential for a complex configuration
      require('nvim-autopairs').setup {}
    end
  },
  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      padding_right = 3,
      padding_top = 7
    }
  },
  {
    'tiagovla/scope.nvim',
    config = function()
      require('scope').setup {}
    end
  },
  {
    'xzbdmw/colorful-menu.nvim',
    config = function ()
      require('colorful-menu').setup {
        max_width = 80
      }
    end
  },
  {
    'akinsho/toggleterm.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('toggleterm').setup {}
    end
  },
  {
    'DaikyXendo/nvim-material-icon',
    config = function ()
      require('nvim-web-devicons').setup {
        color_icons = true,
        default = true
      }
    end
  },
  {
    'seblyng/roslyn.nvim',
    ft = { 'cs' },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      filewatching = 'roslyn'
    }
  },
  {
    'nacro90/numb.nvim',
    config = function()
      -- Has potential for a complex configuration
      require('numb').setup {}
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      -- Has potential for a complex configuration
      require('ts_context_commentstring').setup { enable_autocmd = false }
    end
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = function() vim.cmd('UpdateRemotePlugins') end,
    config = true
  },
  {
    'zeioth/garbage-day.nvim',
    event = 'VeryLazy',
    opts = {
      -- Put misbehaving lsp clients here
      excluded_lsp_clients = { 'marksman' }
    }
  },
  {
    'Wansmer/treesj',
    config = function()
      -- Has potential for a complex configuration
      require('treesj').setup {}
    end
  },
  {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        filetype_exclude = { 'netrw', 'tutor', 'snacks_dashboard', 'snacks_terminal' }
      }
    end
  },
  {
    'mcauley-penney/visual-whitespace.nvim',
    event = 'ModeChanged *:[vV\22]',
    opts = {
      space_char = '·',
      tab_char = '󰌒 '
    }
  },
  {
    'smoka7/multicursors.nvim',
    event = 'VeryLazy',
    dependencies = 'nvimtools/hydra.nvim',
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' }
  },
  {
    'nvimdev/lspsaga.nvim',
    ---@module 'lspsaga'
    ---@type LspsagaConfig
    opts = {
      symbol_in_winbar = { enable = false }
    }
  },
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    ---@module 'yazi'
    ---@type YaziConfig
    opts = {
      open_for_directories = true
    }
  },
  {
    'Bekaboo/dropbar.nvim',
    ---@module 'dropbar'
    ---@type dropbar_configs_t
    opts = {
      menu = {
        win_configs = { border = 'rounded' }
      }
    }
  },
  {
    'numToStr/Comment.nvim',
    -- Has potential for a complex configuration
    config = function()
      local c = require('ts_context_commentstring.integrations.comment_nvim')
      require('Comment').setup {
        pre_hook = c.create_pre_hook()
      }
    end
  },
  {
    'gbprod/phpactor.nvim',
    ft = 'php',
    opts = {
      install = {
        path = vim.fn.stdpath('data') .. '/mason/bin',
        bin = vim.fn.stdpath('data') .. '/mason/bin/phpactor'
      }
    }
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      -- Has potential for a complex configuration
      require('nvim-ts-autotag').setup {
        opts = {
          enable_close = true,
          enable_close_on_slash = true,
          enable_rename = true
        }
      }
    end
  },
  {
    'zbirenbaum/neodim',
    event = 'LspAttach',
    ---@module 'neodim'
    ---@type neodim.Options
    opts = {
      hide = {
        underline = true,
        virtual_text = false,
        signs = true
      }
    }
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    -- Has potential for a complex configuration
    config = function()
      require('ufo').setup {
        provider_selector = function(_, _, _)
          return { 'treesitter', 'indent' }
        end
      }
    end
  },
  {
    'michaelb/sniprun',
    branch = 'master',
    build = 'sh ./install.sh',
    -- do 'sh install.sh 1' if you want to force compile locally
    -- (instead of fetching a binary from the github release). Requires Rust >= 1.65
    config = function()
      require('sniprun').setup {}
    end
  },
  {
    'lewis6991/hover.nvim',
    ---@module 'hover'
    ---@type Hover.Config
    opts = {
      init = function ()
        require('hover.providers.lsp')
        require('hover.providers.man')
        require('hover.providers.dap')
      end,
      preview_opts = { border = 'rounded' }
    }
  },
  {
    'GCBallesteros/jupytext.nvim',
    config = function()
      require('jupytext').setup {
        custom_language_formatting = {
          python = {
            extension = 'md',
            style = 'markdown',
            force_ft = 'markdown' -- you can set whatever filetype you want here
          }
        }
      }
    end
  },
  {
    -- support for image pasting
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      -- recommended settings
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true
        },
        -- required for Windows users
        use_absolute_path = vim.fn.has('win32') and true or false
      }
    }
  },
  {
    'kylechui/nvim-surround',
    event = 'VeryLazy',
    opts = {
      keymaps = {
        insert = '<Nop>',
        insert_line = '<Nop>',
        normal = 'gss',
        normal_cur = 'gss',
        normal_line = 'gsS',
        normal_cur_line = 'gsSs',
        visual = 'gss',
        visual_line = 'gsS',
        delete = 'gsd',
        change = 'gsc',
        change_line = 'gsC'
      }
    }
  },
  {
    'aznhe21/actions-preview.nvim',
    config = function()
      -- Has potential for a more complex configuration
      require('actions-preview').setup {
        backend = 'telescope',
        telescope = {
          sorting_strategy = 'ascending',
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.8,
            -- height = 0.9,
            prompt_position = 'top',
            preview_cutoff = 25,
            ---@param max_lines integer
            preview_height = function(_, _, max_lines)
              return max_lines - 20
            end
          }
        },
        highlight_command = {
          require('actions-preview.highlight').delta()
        }
      }
    end
  },
  {
    'GeorgesAlkhouri/nvim-aider',
    cmd = 'Aider',
    -- Example key mappings for common actions:
    keys = {
      { '<leader>a/', '<cmd>Aider toggle<cr>', desc = 'Toggle Aider' },
      { '<leader>as', '<cmd>Aider send<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
      { '<leader>ac', '<cmd>Aider command<cr>', desc = 'Aider Commands' },
      { '<leader>ab', '<cmd>Aider buffer<cr>', desc = 'Send Buffer' },
      { '<leader>a+', '<cmd>Aider add<cr>', desc = 'Add File' },
      { '<leader>a-', '<cmd>Aider drop<cr>', desc = 'Drop File' },
      { '<leader>ar', '<cmd>Aider add readonly<cr>', desc = 'Add Read-Only' },
      { '<leader>aR', '<cmd>Aider reset<cr>', desc = 'Reset Session' },
      -- Example nvim-tree.lua integration if needed
      {
        '<leader>a+',
        function()
          require('nvim_aider.tree').add_file_from_tree()
        end,
        desc = 'Add File from Tree to Aider',
        ft = 'NvimTree'
      },
      {
        '<leader>a-',
        function()
          require('nvim_aider.tree').drop_file_from_tree()
        end,
        desc = 'Drop File from Tree from Aider',
        ft = 'NvimTree'
      },
    },
    ---@module 'nvim_aider'
    ---@type nvim_aider.Config
    opts = {
      args = {
        '--model',
        'gemini/gemini-2.5-flash',
        '--no-auto-commits',
        '--pretty',
        '--stream'
      }
    }
  },
  {
    'LunarVim/bigfile.nvim',
    config = function()
      local supermaven = {
        name = 'supermaven',
        opts = {
          defer = false
        },
        disable = function()
          vim.cmd('SupermavenStop')
        end
      }

      require('bigfile').setup {
        filesize = 2, -- size of the file in MiB, the plugin round file sizes to the closest MiB
        pattern = { '*' }, -- autocmd pattern or function see <### Overriding the detection of big files>
        features = { -- features to disable
          'indent_blankline',
          'illuminate',
          'lsp',
          'treesitter',
          ---@diagnostic disable-next-line: assign-type-mismatch
          supermaven,
          'syntax',
          'matchparen',
          'vimopts',
          'filetype'
        }
      }
    end
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = 'antosha417/nvim-lsp-file-operations',
    lazy = false,
    config = function()
      ---@param path string
      local function label(path)
        path = path:gsub(tostring(os.getenv('HOME')), '~', 1)
        -- local a = path:gsub('([a-zA-Z])[a-z0-9]+', '%1')
        -- local b = tostring(path:match '[a-zA-Z]([a-z0-9]*)$' or '')
        return path
      end

      -- Has potential for a more complex configuration
      require('nvim-tree').setup {
        filters = { enable = false },
        ---@param bufnr integer
        on_attach = function(bufnr)
          local api = require('nvim-tree.api')

          local function edit_or_open()
            local node = api.tree.get_node_under_cursor()
            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file
              api.node.open.edit()
              -- Close the tree if file was opened
              api.tree.close()
            end
          end

          -- harper:ignore
          -- open as vsplit on current node
          local function vsplit_preview()
            local node = api.tree.get_node_under_cursor()
            if node.nodes ~= nil then
              -- expand or collapse folder
              api.node.open.edit()
            else
              -- open file as vsplit
              api.node.open.vertical()
            end
            -- Finally refocus on tree if it was lost
            api.tree.focus()
          end

          --- (Copied from eddiebergman)
          ---@param desc string
          ---@return table
          local function opts(desc)
            return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          -- default mappings (Copied from eddiebergman)
          api.config.mappings.default_on_attach(bufnr)

          -- Set keymaps on attach (Copied from eddiebergman)
          vim.keymap.set('n', 'l', edit_or_open, opts('Edit or Open'))
          vim.keymap.set('n', 'L', vsplit_preview, opts('Vsplit Preview'))
          vim.keymap.set('n', 'h', api.tree.close, opts('Close'))
          vim.keymap.set('n', 'H', api.tree.collapse_all, opts('Collapse'))
        end,
        renderer = {
          icons = {
            glyphs = {
              git = {
                unstaged = '󰄱',
                staged = '󰱒'
              }
            }
          },
          root_folder_label = label,
          group_empty = label
        }
      }
    end,
    deactivate = function() vim.cmd('NvimTreeClose') end
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    ---@module 'auto-session'
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        load_on_setup = true
      },
      lazy_support = true,
      lsp_stop_on_restore = true,
      suppressed_dirs = { os.getenv('HOME'), '/' },
      continue_restore_on_error = false,
      cwd_change_handling = true,
      pre_restore_cmds = {
        function()
          ---@param name string
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
              local is_true = (vim.bo[bufnr].filetype ~= 'help') or
                (vim.bo[bufnr].filetype ~= 'man') or
                (vim.bo[bufnr].filetype ~= 'gitcommit')

              if is_true and vim.bo[bufnr].modifiable then
                vim.o.fileformats = 'unix,dos,mac'
              end
            end
          })
        end
      }
    }
  }
  -- harper:ignore
  --- Might use again if needed.
  -- {
  --   'ray-x/go.nvim',
  --   dependencies = { 'ray-x/guihua.lua' },
  --   config = function ()
  --     require('go').setup {}
  --   end,
  --   event = 'CmdlineEnter',
  --   ft = { 'go', 'gomod' },
  --   build = function() require('go.install').update_all_sync() end
  -- },
  -- {
  --   'ray-x/lsp_signature.nvim',
  --   event = 'InsertEnter',
  --   opts = {
  --     bind = true,
  --     handler_opts = {
  --       border = 'rounded'
  --     },
  --     hint_prefix = '❔ '
  --   }
  -- },
  -- {
  --   'ray-x/navigator.lua',
  --   dependencies = { 'ray-x/guihua.lua' },
  --   config = function()
  --     -- Has potential for a complex configuration
  --     require('navigator').setup()
  --   end
  -- },
  -- { -- Copied and modified from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/editor/neo-tree.lua
  --   'nvim-neo-tree/neo-tree.nvim',
  --   --- @module 'neo-tree'
  --   --- @type neotree.Config
  --   opts = {
  --     filesystem = {
  --       bind_to_cwd = false,
  --       follow_current_file = { enabled = true },
  --       use_libuv_file_watcher = true,
  --       hijack_netrw_behavior = 'open_current',
  --       filtered_items = {
  --         visible = true,
  --         hide_dotfiles = false,
  --         hide_gitignored = false
  --       }
  --     }
  --   }
  -- },
  -- { -- Needed by neotree
  --   's1n7ax/nvim-window-picker',
  --   name = 'window-picker',
  --   event = 'VeryLazy',
  --   config = true
  -- },
  -- {
  --   'soulis-1256/eagle.nvim',
  --   opts = {
  --     border = 'rounded'
  --   }
  -- },
  -- {
  --   'catgoose/nvim-colorizer.lua',
  --   event = 'BufReadPre',
  --   opts = {}
  -- },
  -- {
  --   'kdheepak/lazygit.nvim',
  --   lazy = false,
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile'
  --   },
  --   keys = {
  --       { '<leader>gg', function() vim.cmd('LazyGit') end, desc = 'LazyGit', noremap = true }
  --   },
  --   config = function()
  --     require('telescope').load_extension('lazygit')
  --   end
  -- },
  -- {
  --   'milanglacier/minuet-ai.nvim',
  --   opts = {
  --     -- notify = 'verbose',
  --     provider = 'gemini',
  --     provider_options = {
  --       gemini = {
  --         model = 'gemini-2.0-flash',
  --         optional = {
  --           generationConfig = {
  --             maxOutputTokens = 256,
  --             -- When using `gemini-2.5-flash`, it is recommended to entirely
  --             -- disable thinking for faster completion retrieval.
  --             thinkingConfig = {
  --               thinkingBudget = 0
  --             }
  --           },
  --           safetySettings = {
  --             {
  --               -- HARM_CATEGORY_HATE_SPEECH,
  --               -- HARM_CATEGORY_HARASSMENT
  --               -- HARM_CATEGORY_SEXUALLY_EXPLICIT
  --               category = 'HARM_CATEGORY_DANGEROUS_CONTENT',
  --               -- BLOCK_NONE
  --               threshold = 'BLOCK_ONLY_HIGH'
  --             }
  --           }
  --         }
  --       }
  --     }
  --   }
  -- },
  -- {
  --   'nvim-zh/colorful-winsep.nvim',
  --   config = function()
  --     require('colorful-winsep').setup {
  --       excluded_ft = { 'packer', 'TelescopePrompt', 'mason', 'NvimTree' },
  --       animate = {
  --         enabled = 'progressive'
  --       }
  --     }
  --   end,
  --   event = { 'WinLeave' }
  -- },
}
