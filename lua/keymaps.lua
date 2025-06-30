-- ~/.config/nvim/lua/keymaps.lua

-- [[ Set up keymaps ]]
-- `vim.keymap.set(modes, lhs, rhs, opts)`:
-- `modes`: 'n' (Normal), 'i' (Insert), 'v' (Visual), 't' (Terminal), etc.
-- `lhs`: The key sequence you press.
-- `rhs`: What Neovim does when you press `lhs`.
-- `opts`: Table for options like `desc` (description for `:h keymap`), `noremap` (don't remap rhs), etc.
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Helper function for setting keymaps.
local map = vim.keymap.set

-- Basic file operations using leader key.
map('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
map('n', '<leader>q', ':q<CR>', { desc = 'Quit Neovim' })
map('n', '<leader>Q', ':q!<CR>', { desc = 'Force Quit Neovim (discard changes)' })
map('n', '<leader>x', ':wq<CR>', { desc = 'Save and Quit' })

-- Use <Esc> to exit terminal mode.
-- `<C-\><C-n>` is the standard way to exit terminal mode to Normal mode.
map('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


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

-- Keybinding for ToggleTerm (must be defined after ToggleTerm is set up by lazy.nvim)
vim.keymap.set('n', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' }) -- Normal mode to open/close
vim.keymap.set('t', '<leader>tt', '<cmd>ToggleTerm<CR>', { desc = 'Toggle Terminal' }) -- Terminal mode to close

--- LSP-SPECIFIC KEYMAPS ---
-- This function will be called from the on_attach callback in your LSP configuration
return function(client, bufnr)
    -- Helper function to set buffer-local keymaps for LSP
    local lsp_map = function(mode, lhs, rhs, opts)
        opts = opts or {}
        opts.buffer = bufnr -- Ensure the mapping is buffer-local
        map(mode, lhs, rhs, opts)
    end

    -- Enable completion triggered by <C-x><C-o> in insert mode
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings for LSP functionalities
    -- See `:help vim.lsp.*` for the functions.
    -- Use `gd` for Go to Definition, `K` for Hover Documentation.
    lsp_map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
    lsp_map('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Info' })
    lsp_map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to Implementation' })
    lsp_map('n', 'gr', vim.lsp.buf.references, { desc = 'Show References' })
    lsp_map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
    lsp_map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })

    -- Diagnostic navigation (errors/warnings)
    lsp_map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
    lsp_map('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })

    local diagnostic_severity = vim.diagnostic.severity

    -- Jump to previous ERROR.
    lsp_map('n', '[e', function()
        vim.diagnostic.goto_prev({ severity = diagnostic_severity.ERROR })
    end, { desc = 'Previous ERROR Diagnostic' })

    -- Jump to next ERROR.
    lsp_map('n', ']e', function()
        vim.diagnostic.goto_next({ severity = diagnostic_severity.ERROR })
    end, { desc = 'Next ERROR Diagnostic' })

    -- Jump to previous WARNING.
    lsp_map('n', '[w', function()
        vim.diagnostic.goto_prev({ severity = diagnostic_severity.WARN })
    end, { desc = 'Previous WARNING Diagnostic' })

    -- Jump to next WARNING.
    lsp_map('n', ']w', function()
        vim.diagnostic.goto_next({ severity = diagnostic_severity.WARN })
    end, { desc = 'Next WARNING Diagnostic' })

    -- Open list with only ERROR.
    lsp_map('n', '<leader>qe', function()
        vim.diagnostic.setloclist({ severity = diagnostic_severity.ERROR })
    end, { desc = 'Quickfix List with ERRORs' })

    -- Open list with WARNING.
    lsp_map('n', '<leader>qw', function()
        vim.diagnostic.setloclist({ severity = diagnostic_severity.WARN })
    end, { desc = 'Quickfix List with WARNINGS ' })
end
