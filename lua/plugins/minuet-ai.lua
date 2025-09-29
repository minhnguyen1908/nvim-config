-- File: ~/.config/nvim/lua/plugins/minuet.lua

return {
    "milanglacier/minuet-ai.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        require("minuet").setup({
            -- This section defines the API key for each provider
            provider_options = {
                gemini = {
                    -- The plugin will automatically look for the GEMINI_API_KEY environment variable
                    api_key = 'GEMINI_API_KEY',
                },
            },
            -- We select the provider to use here
            provider = "gemini",
        })
    end,
}
