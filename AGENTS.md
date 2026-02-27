# Neovim Configuration - AGENTS.md

## Overview

This is a LazyVim-based Neovim configuration written in Lua. It provides a
highly customizable development environment with LSP support,
treesitter, and various productivity plugins.

```txt
lua/
├── utils/
│   └── init.lua          # Utility functions and helper modules
├── plugins/
│   ├── no-config.lua     # Plugins that don't require configuration
│   ├── disabled.lua      # Disabled plugins
│   ├── rocks.lua         # LuaRocks related plugins
│   ├── lsp.lua           # LSP plugin configurations
│   ├── init.lua          # Main plugin specifications
│   └── extra-config.lua  # Extra plugin configurations
├── config/
│   ├── lazy.lua          # Lazy.nvim package manager setup
│   ├── autocmds.lua      # Autocommands configuration
│   ├── keymaps.lua       # Key mappings and bindings
│   └── options.lua       # Neovim options and settings
└── extensions/
    ├── lsp.lua           # LSP server extensions
    └── telescope.lua     # Telescope plugin extensions
init.lua                  # Main Neovim initialization file
lazyvim.json              # Plugins installed with LazyVim
README.md                 # Project documentation
LICENSE                   # License file
stylua.toml               # StyLua formatter configuration
.neoconf.json             # Neodev configuration
lazy-lock.json            # Lazy.nvim lock file
CHANGELOG.md              # Changelog
```

## Key Features

### Completion & Autocomplete

- **nvim-cmp** with sources:
  - nvim_lsp_signature_help

  - nvim_lua

  - dap

  - render-markdown

  - diag-codes

  - luasnip_choice

  - npm

- **lspkind** - LSP kind icons

- **colorful-menu** - Syntax highlighting for completion menu

### Utilities

- `utils.set_indent_size(bufnr)` - Interactive indent size picker

- `utils.switch_indent_style(bufnr)` - Switch between indent styles

### Mason Registries

- mason-org/mason-registry

- Crashdummyy/mason-registry

- MKindberg/ghostty-ls

## Configuration Notes

- **Neovide**: Scale factor set to 1.0 if available

- **Bigfile**: Triggers for files > 2 MiB

- **Auto-session**: Loads on setup, supports lazy loading

- **Nvim-tree**: Syncs root with CWD, respects buffer CWD

- **Comment.nvim**: Uses treesitter context for comment strings

- **Jupytext**: Python files saved as markdown with ` ``` ` style

## Development Guidelines

- All configurations are written in Lua

- Plugin specs follow LazyVim conventions

- Use `---@module` annotations for type hints

- Diagnostic warnings can be disabled with `---@diagnostic disable-next-line`

- Utility functions are centralized in `lua/utils/init.lua`

## Dependencies

- **LazyVim/LazyVim** - Base configuration (optional, commented out)

- **LazyVim/LazyExtras** - Extra plugins

- **nvim-lspconfig** - LSP configuration

- **mason.nvim** - Package manager for LSP servers

- **telescope.nvim** - Fuzzy finder

- **nvim-cmp** - Completion engine

- **null-ls** - LSP source for code actions, diagnostics, formatting

## Customization

To add new plugins or modify configurations:

1. Add plugin specs to `lua/plugins/init.lua`

2. Add LSP configurations to `lua/plugins/lsp.lua`

3. Add key mappings to `lua/config/keymaps.lua`

4. Add autocmds to `lua/config/autocmds.lua`

5. Add utility functions to `lua/utils/init.lua`
