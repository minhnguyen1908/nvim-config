-- Bridges mason.nvim with the nvim-lspconfig plugin, making it easier to set up LSP servers.
return {
    'williamboman/mason-lspconfig.nvim',
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
}
