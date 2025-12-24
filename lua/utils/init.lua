-- local telescope = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
-- local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local utils = {}


---Allows for setting a function to pick a value for shiftwidth or tabstop
---@param bufnr integer
function utils.set_indent_size(bufnr)
  pickers.new(
    {
      layout_config = {
        height = 5,
        width = 60
      }
    },
    {
      prompt_title = 'Set the Indent Size',
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
    }
  ):find()
end


---Allows for switching between tabs or spaces.
---@param bufnr integer
function utils.switch_indent_style(bufnr)
  vim.bo[bufnr].expandtab = not vim.bo[bufnr].expandtab

  if vim.bo[bufnr].expandtab then
    -- Switched to spaces, set a common default for shiftwidth
    vim.bo[bufnr].expandtab = true
    vim.bo[bufnr].tabstop = 2
    vim.bo[bufnr].shiftwidth = 2
    vim.cmd('retab')

    ---@diagnostic disable-next-line: param-type-mismatch
    require('guess-indent').set_from_buffer(bufnr, true, true)
    print('Switched Indent Style to Spaces')
  else
    -- Switched to tabs, set a common default for tabstop
    vim.bo[bufnr].expandtab = false
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].tabstop = 4
    vim.cmd('retab')

    ---@diagnostic disable-next-line: param-type-mismatch
    require('guess-indent').set_from_buffer(bufnr, true, true)
    print('Switched Indent Style to Tabs')
  end
end


return utils
