---@diagnostic disable: missing-fields, type-not-found

---Common LSP server/client configuration options.
---@class lspClientOpts : lspconfig.Config
---
---Allows for disabling or enabling mason.nvim integration
---for this LSP server. By default, this is set to `true`
---@field mason boolean?
---
---Allows for setting custom keymaps for this LSP server.
---@field keys vim.api.keyset.keymap[]

-- TODO: Add more fields for better diagnostics, hints, and completion.

---This type annotation tries to include all the required fields
---for all LSP server configurations. This is a **WIP** and may not
---feature all _necessary_ fields.
---@class lspConfigOpts
---
---Allows for configuring inlay hints for this LSP server.
---@field inlay_hints { enabled: boolean? }
---
---Common LSP server/client configuration options.
---@field servers { [string]: lspClientOpts }
---
---@field setup { [string]: fun(_: any, client: lspClientOpts) }

---@type lspConfigOpts
local M = {}

return M
