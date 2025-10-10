-- lua/plugins/lazydev.lua
return {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
        -- library = {
        --     -- You can add paths to other libraries here.
        --     -- For example, to load luvit types when `vim.uv` is found.
        --     { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        -- }
    },
}
