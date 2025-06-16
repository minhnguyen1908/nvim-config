-- PLUGIN 3 & 4: Mason and Mason-LSPConfig for managing and setting up Language Servers.
-- Language Servers provide IDE-like features (autocompletion, hover docs, diagnostics, go-to-definition).
-- Mason manages the installation of the actual language server executables (e.g., `dockerfile-language-server`).
return {{ 'williamboman/mason.nvim', config = true }, -- Basic setup for Mason.

    { 'williamboman/mason-lspconfig.nvim',
        dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
        config = function()
            require('mason-lspconfig').setup {
                automatic_setup = true,
                -- `ensure_installed` will make Mason download these LSP servers automatically on first run.
                ensure_installed = {
                    'dockerls', -- For Dockerfiles
                    'docker_compose_language_service',
                    'lua_ls',             -- For Neovim config (Lua)
                    'bashls',             -- For shell scripts
                    'jsonls',             -- For JSON files
                    'yamlls',             -- For YAML files (Kubernetes, Docker Compose, Ansible)
                    'pyright',            -- For Python
                    -- Add more as you need, e.g., 'tsserver' for TypeScript, 'gopls' for Go, 'terraformls' for Terraform.
                },
            }
        end
    },
}
