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
    end,
}
