-- local telescope = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Define the custom picker function
local function set_shiftwidth_prompt()
  pickers.new(
    {
      layout_config = {
        height = 5
      }
    },
    {
      prompt_title = (function()
        if vim.bo.expandtab then
          return 'Set the Space Size'
        else
          return 'Set the Tab Width'
        end
      end)(),
      finder = finders._new {}, -- Use a static finder with no results
      -- sorter = conf.generic_sorter {}, -- Use a generic sorter

      -- Define custom actions
      attach_mappings = function(prompt_bufnr, map)
        -- Default action ( pressing Enter )
        actions.select_default:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local input = current_picker:_get_prompt() -- Get the input from the prompt

          -- Close the picker
          actions.close(prompt_bufnr)
          -- Attempt to convert input to a number
          local value = tonumber(input)

          if value and value >= 0 then
            -- Set the shiftwidth and tabstop options
            if vim.bo.expandtab then
              vim.opt.shiftwidth = value
            else
              vim.opt.tabstop = value
            end
          else
            print('Invalid input: Please enter a non-negative number')
          end
        end)

        -- You can add other mappings here if needed (e.g., for cancelling)
        -- map('i', '<C-c>', actions.close)

        return true
      end
    }):find()
end

-- Return the function so it can be required and mapped
return { set_shiftwidth_prompt = set_shiftwidth_prompt }
