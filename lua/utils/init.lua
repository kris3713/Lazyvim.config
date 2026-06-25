local utils = {}

---Allows for setting a function to pick a value for shiftwidth or tabstop
---@param bufnr integer
function utils.set_indent_size(bufnr)
  Snacks.input({
    prompt = 'Set Indent Size',
    icon = ' ',
    win = {
      position = 'float',
    },
  }, function(input)
    if not input then
      return
    end

    local value = tonumber(input)
    if value and value >= 0 then
      -- Set the shiftwidth and tabstop options
      if vim.bo[bufnr].expandtab then
        vim.notify(('Set indent size to %d for spaces'):format(value))
        vim.bo[bufnr].shiftwidth = value
      else
        vim.notify(('Set indent size to %d for tabs'):format(value))
        vim.bo[bufnr].tabstop = value
      end
    else
      vim.notify('Invalid input: Please enter a non-negative number')
    end
  end)
end

---Allows for switching between tabs or spaces.
---@param bufnr integer
function utils.switch_indent_style(bufnr)
  local guess_indent = require('guess-indent')
  local indent_style = guess_indent.guess_from_buffer(bufnr)
  vim.bo[bufnr].expandtab = not vim.bo[bufnr].expandtab

  if indent_style ~= 'tabs' and vim.bo[bufnr].expandtab then
    -- Switched to spaces, set a common default for shiftwidth
    vim.bo[bufnr].smartindent = true
    vim.bo[bufnr].autoindent = true
    vim.bo[bufnr].expandtab = true
    vim.bo[bufnr].tabstop = 2
    vim.bo[bufnr].shiftwidth = 2
    vim.bo[bufnr].softtabstop = 2
    vim.cmd('retab ' .. 2)

    ---@diagnostic disable-next-line: param-type-mismatch
    guess_indent.set_from_buffer(bufnr, true, true)
    print('Switched Indent Style to Spaces')
  else
    -- Switched to tabs, set a common default for tabstop
    vim.bo[bufnr].smartindent = false
    vim.bo[bufnr].autoindent = false
    vim.bo[bufnr].expandtab = false
    vim.bo[bufnr].tabstop = 4
    vim.bo[bufnr].shiftwidth = 4
    vim.bo[bufnr].softtabstop = 4
    vim.cmd('retab ' .. 4)

    ---@diagnostic disable-next-line: param-type-mismatch
    guess_indent.set_from_buffer(bufnr, true, true)
    print('Switched Indent Style to Tabs')
  end
end

return utils
