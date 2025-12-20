---@diagnostic disable: missing-fields

--harper: ignore

---Common LSP server/client configuration options.
---This extends the `vim.lsp.ClientConfig`, `vim.lsp.Client`, and `vim.lsp.Config` types.
---@class lspClientOpts : vim.lsp.Config
---
---Allows for disabling or enabling mason.nvim integration
---for this LSP server. By default, this is set to `true`
---@field mason boolean?
---
---Allows for setting custom keymaps for this LSP server.
---@field keys vim.api.keyset.keymap[]
---
---Callback invoked when a new configuration is created.
---@field on_new_config fun(config: vim.lsp.ClientConfig, root_dir: string?)

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
---@field servers { [string]: lspClientOpts | vim.lsp.Client }

---@type lspConfigOpts
local M = {}

return M
