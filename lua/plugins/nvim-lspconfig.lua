-- PLUGIN 5: nvim-lspconfig for configuring the native Neovim LSP client.
-- This plugin helps Neovim communicate with the language servers Mason installs.
return {
    'neovim/nvim-lspconfig',
    dependencies = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' },
    config = function()
        local lspconfig = require('lspconfig')
        -- `capabilities` informs the LSP server about Neovim's features (e.g., snippet support).
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        -- Load the keymap function from your centralized keymaps file
        -- This function will be used as the on_attach callback for LSP servers
        local attach_lsp_keymaps = require('keymaps')

        -- Setup individual LSP servers. Mason will ensure these are installed.
        -- Each `setup` call configures the LSP client for a specific language.
        lspconfig.dockerls.setup {
            capabilities = capabilities,
            on_attach = attach_lsp_keymaps,
            filetypes = { 'dockerfile' },
        }
        lspconfig.lua_ls.setup {
            capabilities = capabilities,
            on_attach = attach_lsp_keymaps,
            filetypes = { 'lua' },
        }
        lspconfig.bashls.setup { capabilities = capabilities, on_attach = attach_lsp_keymaps }
        lspconfig.jsonls.setup { capabilities = capabilities, on_attach = attach_lsp_keymaps }
        lspconfig.yamlls.setup { capabilities = capabilities, on_attach = attach_lsp_keymaps }
        lspconfig.pyright.setup { capabilities = capabilities, on_attach = attach_lsp_keymaps }

        -- You can add more LSP setups here as you install more servers via Mason.
        -- Example: lspconfig.tsserver.setup { capabilities = capabilities, on_attach = on_attach }
    end,
}
