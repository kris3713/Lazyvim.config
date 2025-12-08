---@diagnostic disable: missing-fields

---@class lspClientOpts : vim.lsp.Config
---Allows for disabling or enabling mason.nvim integration
---for this LSP server. By default, this is set to `true`
---@field mason boolean?
---Allows for setting custom keymaps for this LSP server.
---@field keys vim.keymap.set.Opts[]

---@class lspConfigOpts
---@field servers { [string]: lspClientOpts }
---Allows for disabling or enabling inlay hints.
---@field inlay_hints { enabled: boolean? }

---@type lspConfigOpts
local lspconfigOpts = {}

return lspconfigOpts
