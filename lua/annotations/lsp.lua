---@meta _

---@diagnostic disable: missing-fields

--harper: ignore

---@class inlayHintsOpts
---
---Enable or Disable inlay hints. The default value is `true`
---@field enabled boolean?
---
---Filetypes for which you don't want to enable inlay hints
---@field exclude string[]

---Common LSP server/client configuration options.
---This extends the `vim.lsp.ClientConfig`, `vim.lsp.Client`, and `vim.lsp.Config` types.
---@class lspClientOpts : vim.lsp.Config
---
---Allows for disabling or enabling mason.nvim integration
---for this LSP server. By default, this is set to `true`
---@field mason boolean?
---
---@field enabled boolean?
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
---Diagnostics configuration options.
---@field diagnostics vim.diagnostic.Opts
---
---Inlay hints configuration options.
---@field inlay_hints inlayHintsOpts
---
---Common LSP server/client configuration options.
---@field servers table<string, (lspClientOpts | vim.lsp.Client)>
---
---Extra LSP server/client configuration options. Mostly used for workarounds.
---@field setup table<string, fun(server: string, opts: (lspClientOpts | vim.lsp.Client)): boolean?>
