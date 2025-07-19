-- local telescope = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

--- Allows for setting a function to pick a value for shiftwidth or tabstop
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
      ---@param prompt_bufnr integer
      attach_mappings = function(prompt_bufnr, _)
        -- Default action ( pressing Enter )
        actions.select_default:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local input = current_picker:_get_prompt() -- Get the input from the prompt

          -- Close the picker
          actions.close(prompt_bufnr)
          -- Attempt to convert input to a number
          local value = tonumber(input)

          if value and value >= 0 then
            local bufnr = vim.api.nvim_get_current_buf()
            -- Set the shiftwidth and tabstop options
            if vim.bo[bufnr].expandtab then
              vim.bo[bufnr].shiftwidth = value
            else
              vim.bo[bufnr].tabstop = value
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
