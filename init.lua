-- This file is Neovim's main configuration file.
-- It's written in Lua, a lightweight, multi-paradigm programming language.
-- For documentation, use `:help <topic>` in Neovim, e.g., `:help vim.o` for options.

-- Set <space> as the leader key.
-- The leader key is a prefix for custom keybindings and many plugins.
-- NOTE: This must happen before plugins are loaded (otherwise wrong leader will be used).
-- See `:help mapleader` for more information.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' -- Also set localleader, useful for buffer-specific maps.

-- [[ Setting global Neovim options ]]
-- These options control Neovim's behavior, appearance, and core functionality.
-- See `:help option-list` for a full list, and `:help 'optionname'` for individual option docs.

vim.o.number = true           -- Print the line number in front of each line.
vim.o.relativenumber = true   -- Use relative line numbers, which makes jumping with `j` and `k` much easier.
                              -- This will affect the 'number' option, see `:h number_relativenumber`.

vim.o.termguicolors = true    -- Enable true colors (24-bit RGB) in the terminal if supported.
                              -- Essential for most modern colorschemes to display correctly.

vim.o.expandtab = true        -- Use spaces instead of tabs when you press the Tab key.
vim.o.tabstop = 4             -- Set the visual width of a tab character to 4 spaces.
vim.o.shiftwidth = 4          -- Set the number of spaces for indentation (e.g., when using `>>` or `==`).
vim.o.autoindent = true       -- Automatically indent new lines to match the previous line's indentation.
vim.o.smartindent = true      -- Smarter auto-indentation specifically for programming languages.

vim.o.mouse = 'a'             -- Enable mouse support in all modes ('a' means all modes).
                              -- Optional, but can be helpful for beginners or for quick window resizing.

vim.o.wrap = false            -- Do not wrap lines. Lines will extend horizontally.
                              -- Generally preferred for code and configuration files.

vim.o.hlsearch = true         -- Highlight all matches when searching.
vim.o.incsearch = true        -- Show partial matches as you type your search query (incremental search).

vim.o.ignorecase = true       -- Ignore case when searching (`/pattern` matches 'Pattern', 'pattern').
vim.o.smartcase = true        -- Don't ignore case if your search pattern contains uppercase characters.
                              -- E.g., `/foo` matches 'Foo', 'foo'; but `/Foo` only matches 'Foo'.

vim.o.cursorline = true       -- Highlight the line where the cursor is on.

vim.o.scrolloff = 10          -- Keep a minimal number of screen lines (10) above and below the cursor.
                              -- Prevents the cursor from sticking to the very top or bottom of the screen.

vim.o.list = true             -- Show special characters like tabs (`^I`) and trailing spaces (`$`).
                              -- Helpful for maintaining clean code.

vim.o.confirm = true          -- If performing an operation that would fail due to unsaved changes (like `:q`),
                              -- instead raise a dialog asking if you wish to save the current file(s).

vim.o.undofile = true         -- Enable persistent undo. Your undo history is saved across sessions.
vim.o.undodir = vim.fn.stdpath("data") .. "/undodir" -- Specify the directory for persistent undo files.
                                                     -- `vim.fn.stdpath("data")` is cross-platform.

-- Create the undo directory if it does not exist.
local undodir = vim.o.undodir
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "p")
end

-- Sync clipboard between OS and Neovim.
-- This sets `clipboard='unnamedplus'` which makes Neovim use the system clipboard for yanking/pasting.
-- We schedule it to run after `UIEnter` to potentially improve startup time.
-- Remove this if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.o.clipboard = 'unnamedplus'
  end,
})

-- Open nvim-tree automatically when Neovim starts without a specific file
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    -- Check if no files were opened and if the current buffer is empty
    if #vim.api.nvim_list_bufs() == 1 and vim.bo.buftype == '' and vim.fn.argv(0) == nil then
      vim.cmd('NvimTreeOpen')
    end
  end,
  group = vim.api.nvim_create_augroup('NvimTreeAutoOpen', { clear = true }),
  desc = 'Open NvimTree on startup if no file is specified',
})

-- [[ Set up keymaps ]]
-- `vim.keymap.set(modes, lhs, rhs, opts)`:
-- `modes`: 'n' (Normal), 'i' (Insert), 'v' (Visual), 't' (Terminal), etc.
-- `lhs`: The key sequence you press.
-- `rhs`: What Neovim does when you press `lhs`.
-- `opts`: Table for options like `desc` (description for `:h keymap`), `noremap` (don't remap rhs), etc.
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Basic file operations using leader key
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save File' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit Neovim' })
vim.keymap.set('n', '<leader>Q', ':q!<CR>', { desc = 'Force Quit Neovim (discard changes)' })
vim.keymap.set('n', '<leader>x', ':wq<CR>', { desc = 'Save and Quit' })

-- Use <Esc> to exit terminal mode.
-- `<C-\><C-n>` is the standard way to exit terminal mode to Normal mode.
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Map <A-j>, <A-k>, <A-h>, <A-l> (Alt + arrows) to navigate between windows (splits).
-- These are very efficient for split-screen workflows.
-- In 't' (Terminal) and 'i' (Insert) modes, we first exit to Normal mode, then move.
vim.keymap.set({ 't', 'i' }, '<A-h>', '<C-\\><C-n><C-w>h', { desc = 'Move to left window' })
vim.keymap.set({ 't', 'i' }, '<A-j>', '<C-\\><C-n><C-w>j', { desc = 'Move to down window' })
vim.keymap.set({ 't', 'i' }, '<A-k>', '<C-\\><C-n><C-w>k', { desc = 'Move to up window' })
vim.keymap.set({ 't', 'i' }, '<A-l>', '<C-\\><C-n><C-w>l', { desc = 'Move to right window' })
-- In Normal mode, we directly move between windows.
vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Move to down window' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Move to up window' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Move to right window' })
-- Use <leader>p (paste) followed by 'l' (line below) to paste the content from OS clipboard
vim.keymap.set('n', '<leader>pl', 'o<C-r>+<Esc>', { desc = 'Paste system clipboard to new line below' })

-- [[ Basic Autocommands ]]
-- Autocommands automatically execute commands when certain events occur (e.g., opening a file).
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`.

-- Highlight when yanking (copying) text.
-- When you yank text (`y`), it briefly highlights the yanked text.
-- Try it with `yap` (yank a paragraph) in Normal mode. See `:h vim.hl.on_yank()`.
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank() -- Changed from vim.hl.on_yank() to vim.highlight.on_yank() for consistency with modern APIs
  end,
})

-- [[ Create user commands ]]
-- User commands are custom commands you can define and execute with `:CommandName`.
-- See `:h nvim_create_user_command()` and `:h user-commands`.

-- Create a command `:GitBlameLine` that prints the git blame for the current line.
vim.api.nvim_create_user_command('GitBlameLine', function()
  local line_number = vim.fn.line('.') -- Get the current line number. See `:h line()`.
  local filename = vim.api.nvim_buf_get_name(0) -- Get the current buffer's file path.
  print(vim.fn.system({ 'git', 'blame', '-L', line_number .. ',+1', filename }))
end, { desc = 'Print the git blame for the current line' })


-- [[ Plugin Manager Setup: lazy.nvim ]]
-- This section installs and configures the `lazy.nvim` plugin manager itself.
-- This block MUST be at the very top of your plugin definitions.
--------------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- Recommended for stability
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This is the `lazy.nvim` configuration block where you define all your plugins.
-- Each plugin is defined as a table `{ 'owner/repo', config = function() ... end }`.
--------------------------------------------------------------------------------------
require("lazy").setup({
    { import = "plugins" },

    -- PLUGIN 1: nvim-treesitter for intelligent syntax highlighting and indentation.
    -- This uses a parsing engine for more accurate and robust highlighting than traditional regex.
    -- ~/.config/nvim/lua/plugins/treesitter.lua

    -- PLUGIN 2: akinsho/toggleterm.nvim for integrated terminal management.
    -- Allows you to easily toggle a floating or split terminal inside Neovim.
    -- ~/.config/nvim/lua/plugins/toggleterm.lua

    -- PLUGIN 3 & 4: Mason and Mason-LSPConfig for managing and setting up Language Servers.
    -- Language Servers provide IDE-like features (autocompletion, hover docs, diagnostics, go-to-definition).
    -- Mason manages the installation of the actual language server executables (e.g., `dockerfile-language-server`).
    -- ~/.config/nvim/lua/plugins/mason.lua

  -- PLUGIN 5: nvim-lspconfig for configuring the native Neovim LSP client.
  -- This plugin helps Neovim communicate with the language servers Mason installs.
    { 'neovim/nvim-lspconfig',
        dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
        config = function()
            local lspconfig = require('lspconfig')
            -- `capabilities` informs the LSP server about Neovim's features (e.g., snippet support).
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true

            -- Helper function to set up LSP servers easily.
            local on_attach = function(client, bufnr)
                -- Enable completion triggered by <C-x><C-o> in insert mode
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

                -- Mappings.
                -- See `:help vim.lsp.*` for the functions.
                -- Use `gd` for Go to Definition, `K` for Hover Documentation.
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Go to Definition' })
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover Info' })
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Go to Implementation' })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Show References' })
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename Symbol' })
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code Action' })

                -- Diagnostic navigation (errors/warnings)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'Previous Diagnostic' })
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'Next Diagnostic' })

                -- *** ADD NEW MAPPINGS FOR FILTERED DIAGNOSTIC ***
                local diagnostic_severity = vim.diagnostic.severity

                -- Jum to previous ERROR.
                vim.keymap.set('n', '[e', function ()
                    vim.diagnostic.goto_prev({ severity = diagnostic_severity.ERROR })
                end, { buffer = bufnr, desc = 'Previous ERROR Diagnostic'})

                -- Jump to next ERROR.
                vim.keymap.set('n', ']e', function ()
                    vim.diagnostic.goto_next({ severity = diagnostic_severity.ERROR }) 
                end, { buffer = bufnr, desc = 'Next ERROR Diagnostic'})

                -- Jump to previous WARNING.
                vim.keymap.set('n', '[w', function ()
                    vim.diagnostic.goto_prev({ severity = diagnostic_severity.WARN }) 
                end, { buffer = bufnr, desc = 'Previous WARNING Diagnostic' })

                -- Jump to next WARNING.
                vim.keymap.set('n', ']w', function ()
                    vim.diagnostic.goto_next({ severity = diagnostic_severity.WARN }) 
                end, { buffer = bufnr, desc = 'Next WARNING Diagnostic'})

                -- Open list with only ERROR.
                vim.keymap.set('n','<leader>qe', function ()
                    vim.diagnostic.setloclist({ severity = diagnostic_severity.ERROR }) 
                end, { buffer = bufnr, desc = 'Quickfix List with ERRORs' })

                -- Open list with WARNING.
                vim.keymap.set('n', '<leader>qw', function ()
                    vim.diagnostic.setloclist({ severity = diagnostic_severity.WARN }) 
                end, { buffer = bufnr, desc = 'Quickfix List with WARNINGS '})

                -- *** END OF NEW MAPPINGS ***
            end

            -- Setup individual LSP servers. Mason will ensure these are installed.
            -- Each `setup` call configures the LSP client for a specific language.
            lspconfig.dockerls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { 'dockerfile' },
            }
            lspconfig.lua_ls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            }
            lspconfig.bashls.setup { capabilities = capabilities, on_attach = on_attach }
            lspconfig.jsonls.setup { capabilities = capabilities, on_attach = on_attach }
            lspconfig.yamlls.setup { capabilities = capabilities, on_attach = on_attach }
            lspconfig.pyright.setup { capabilities = capabilities, on_attach = on_attach }

            -- You can add more LSP setups here as you install more servers via Mason.
            -- Example: lspconfig.tsserver.setup { capabilities = capabilities, on_attach = on_attach }
        end
    },

    -- PLUGIN 6: nvim-cmp for intelligent autocompletion.
    -- This takes suggestions from LSP, buffers, paths, and presents them in a nice pop-up.
    -- ~/.config/nvim/lua/plugins/cmp.lua

  -- PLUGIN 7: Optional Colorscheme.
  -- This changes the visual theme of Neovim. Choose one that you find aesthetically pleasing!
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000,
    config = function()
      vim.cmd.colorscheme 'catppuccin-macchiato' -- You can try 'catppuccin-mocha', 'catppuccin-latte', 'catppuccin-frappe'
    end
  },

  -- PLUGIN 8: nvim-tree.lua - A modern file explorer.
  -- Very useful for navigating project directories.
  { 'nvim-tree/nvim-tree.lua',
        version = '*', -- Use '*' to get the latest stable version unless specific version is needed
        dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For file icons (requires a Nerd Font)
        config = function()
          require('nvim-tree').setup {
            -- `filters` configuration has changed. `exclude_dir` is now part of `custom`.
            filters = {
                dotfiles = false,
                -- Use `custom` for both file and directory exclusions.
                custom = { 'npm-debug.log', 'yarn-error.log', '.git', 'node_modules', '.cache' },
            },
            actions = {
                open_file = {
                    quit_on_open = true, -- Close nvim-tree automatically after opening a file
                    resize_window = true,
                },
            },
            view = {
                width = 30,          -- Default width of the tree
                relativenumber = true, -- Show relative numbers in the tree view
                side = 'left',       -- Position the tree on the left side
            },
            renderer = {
                group_empty = true,
                highlight_git = "all", -- `highlight_git` moved directly under `renderer`
            },
            git = {
                ignore = false,      -- Don't ignore files in .gitignore
--                highlight = true ,    -- This highlights the git status signs in the tree view
            },
            update_focused_file = {
                enable = true,       -- Keep tree in sync with currently open buffer
                update_root = true,
                ignore_list = {},
            },
          }
          -- Keybindings for nvim-tree
          vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree (file explorer)' })
          vim.keymap.set('n', '<leader>E', ':NvimTreeFocus<CR>', { desc = 'Focus NvimTree' })
        end
   },

    -- PLUGIN 9: telescope.nvim - A highly extensible fuzzy finder.
    -- Incredibly powerful for quickly finding files, text content, Git commits, and more.
    -- ~/.config/nvim/lua/plugins/telescope.lua

  -- PLUGIN 10: nvim-lualine/lualine.nvim - A fast and highly customizable Neovim statusline.
  -- Makes your statusline at the bottom of the screen much more informative and good-looking.
  { 'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- For filetype icons in the statusline
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto', -- 'auto' or try 'onedark', 'material', 'tokyonight', etc.
          component_separators = { left = '?', right = '?'}, -- Aesthetic separators
          section_separators = { left = '?', right = '?'},    -- Aesthetic separators
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_last_status = true,
          padding = 1,
        },
        sections = { -- Customize what goes into each section of the statusline
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = { -- What shows up in inactive window statuslines
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {}, -- You can also configure a tabline
        extensions = {'nvim-tree', 'lazy'} -- Integrate with other plugins
      }
    end
  },
    -- PLUGIN 11: markdown-preview
  {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown', -- Only load this plugin for markdown files
        build = 'cd app && npm install', -- Install Node.js dependencies
        init = function ()
            vim.g.mkdp_brower = 'google-chrome'
        end,
  },
})

-- Additional Keybindings (can go here after plugins are defined)
--------------------------------------------------------------------------------------
-- Keybinding for ToggleTerm (must be defined after ToggleTerm is set up by lazy.nvim)
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' }) -- Normal mode to open/close
vim.keymap.set('t', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' }) -- Terminal mode to close

-- [[ Add optional packages ]]
-- Nvim comes bundled with a set of packages that are not enabled by
-- default. You can enable any of them by using the `:packadd` command.
-- These are typically added at the end of the config.

-- For example, to add the "nohlsearch" package to automatically turn off search highlighting after
-- 'updatetime' and when going to insert mode
vim.cmd('packadd! nohlsearch')
-- vim.cmd('source ~/.config/nvim/db_connections.vim')
