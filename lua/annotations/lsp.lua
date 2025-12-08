---@diagnostic disable: missing-fields

---@module 'lspconfig'
---@class lspClientOpts : vim.lsp.Config | {mason?:boolean, enabled?:boolean, keys?:LazyKeysLspSpec[]}
---
---Allows for disabling or enabling mason.nvim integration
---for this LSP server. By default, this is set to `true`
---@field mason boolean?
---
---Allows for setting custom keymaps for this LSP server.
---@field keys vim.keymap.set.Opts[]
---
---Include specific filetypes for this LSP server
---in addition to the default filetypes.
---@field filetypes_include string[]?
---
---Exclude specific filetypes from this LSP server
---without changing the default filetypes.
---@field filetypes_exclude string[]?

---This type annotation tries to include all the required fields
---for any LSP server configuration. This is a WIP and may not
---feature all necessary fields.
---@class lspConfigOpts
---
---Allows for disabling or enabling inlay hints.
---@field inlay_hints { enabled: boolean? }
---
---@field servers { [string]: lspClientOpts }

---@type lspConfigOpts
local M = {}

return M
