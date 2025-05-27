-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Remove annoying autoformat
vim.g.autoformat = false

-- Improved sessionoptions
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

-- Set font family and font size (For Neovide and Neovim-Qt)
vim.opt.guifont = { 'JetBrainsMono Nerd Font', ':h16' }

-- Set softwrapping to always be true
vim.opt.wrap = true

-- Ensure all indents are spaces and have a width of 2
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- -- Set leader key
-- vim.g.mapleader = ","

-- Change the default cursor (for Insert mode) to a vertical line
vim.opt.guicursor = 'i:ver25-iCursor'

-- Set lazyvim picker to telescope
vim.g.lazyvim_picker = 'telescope'

-- Enable smooth scrolling
vim.o.smoothscroll = true

-- Set lualine status
vim.g.lualine_laststatus = 2

-- Set lazyvim completion engine
vim.g.lazyvim_cmp = 'nvim-cmp'

--- Custom filetypes
-- `msbuild`
vim.filetype.add {
  extension = {
    props = 'msbuild',
    tasks = 'msbuild',
    targets = 'msbuild'
  },
  pattern = { [ [[.*\..*proj]] ] = 'msbuild' }
}

-- `yaml.docker-compose`
vim.filetype.add {
  filename = {
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose'
  },
  pattern = { [ [[.*\..*compose.*]] ] = 'yaml.docker-compose' }
}

vim.treesitter.language.register('xml', { 'msbuild' })

-- Set listchars
vim.o.listchars = 'tab:󰌒 ,trail:·,space:·,nbsp:+'

-- Enable list
vim.o.list = true

-- Change current directory when opening a file
vim.o.acd = true

-- Remove snippets from completion that are not related to the current file.
vim.g.lazyvim_mini_snippets_in_completion = false

-- Ensure the encoding is always UTF-8
vim.o.encoding = 'utf-8'

-- Mouse support
vim.o.mousemoveevent = true
vim.opt.mouse = 'a'

-- nvim-ufo
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Disable netrw
vim.g.loaded_netrw = false
vim.g.loaded_netrwPlugin = false

-- Stop line numbers from shifting forward and back
vim.o.signcolumn = 'yes:2'

-- Ensure Neovim always create an undo file
vim.o.undofile = true

-- Ensure the relative line number is always shown
vim.o.relativenumber = false

--- LSP configs
-- -- Astro
-- vim.lsp.enable('astro')

-- -- Lua
-- vim.lsp.enable('lua_ls')

-- Ruby
vim.lsp.enable('solargraph')
vim.lsp.config('ruby_lsp', {})
vim.lsp.enable('ruby_lsp')
vim.lsp.enable('rubocop')

-- Python
vim.lsp.enable('basedpyright')
vim.lsp.enable('ruff')

-- Golang
vim.lsp.enable('golangci_lint_ls')

-- -- Java
-- vim.lsp.enable('jdtls')

-- Gradle
vim.lsp.enable('gradle_ls')

-- rpmspec
vim.lsp.enable('rpmspec')

-- CSS
vim.lsp.enable({ 'cssls', 'cssmodules_ls', 'css_variables' })

-- GitHub Actions
vim.lsp.enable('gh_actions_ls')

-- -- Markdown
-- vim.lsp.enable('marksman')

-- -- Omnisharp
-- vim.lsp.enable('omnisharp')

-- Roslyn ls
vim.lsp.enable('roslyn_ls')

-- MSBuild
local msbuild = os.getenv('MSBUILD_LSP')
if (msbuild ~= '') and (msbuild ~= nil) then
  vim.lsp.enable('msbuild_project_tools_server')
end

-- -- TypeScript/JavaScript (vtsls)
-- vim.lsp.enable('vtsls')

-- -- Biome
-- vim.lsp.enable('biome')

-- -- Harper
-- vim.lsp.enable('harper_ls')

-- -- Vue
-- vim.lsp.enable('volar')

-- -- Prisma
-- vim.lsp.enable('prismals')

-- Containers
vim.lsp.enable({ 'dockerls', 'docker_compose_language_service' })

-- -- Nushell
-- vim.lsp.enable('nushell')

-- FISH
vim.lsp.enable('fish_lsp')

-- -- BASH
-- vim.lsp.enable('bashls')

-- XML
vim.lsp.enable('lemminx')

-- -- YAML
-- vim.lsp.enable('yamlls')

-- -- JSON
-- vim.lsp.enable('jsonls')

-- Stylelint
vim.lsp.enable('stylelint_lsp')

-- PowerShell
vim.lsp.enable('powershell_es')

-- -- Eslint
-- vim.lsp.enable('eslint')
