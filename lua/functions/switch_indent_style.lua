--- Allows for switching between tabs or spaces.
---@param bufnr integer
local function switch_indent_style(bufnr)
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

return { switch_indent_style = switch_indent_style }
