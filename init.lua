-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Get rid of Neovim's stupid cursor change
local restore_cursor_augroup = vim.api.nvim_create_augroup("restore_cursor_shape_on_exit", { clear = true })
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  group = restore_cursor_augroup,
  desc = "restore the cursor shape on exit of neovim",
  command = "set guicursor=a:ver20",
})

-- Set font family and font size
vim.opt.guifont = { "JetBrainsMono Nerd Font", ":h16" }

-- Set zoom function
vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
vim.keymap.set("n", "<C-=>", function()
  change_scale_factor(1.25)
end)
vim.keymap.set("n", "<C-->", function()
  change_scale_factor(1/1.25)
end)
