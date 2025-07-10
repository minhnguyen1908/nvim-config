-- PLUGIN 11: markdown-preview
return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install", -- Install Node.js dependencies
    init = function ()
        vim.g.mkdp_filetypes = { "markdown" }
        vim.g.mkdp_brower = "google-chrome"
    end,
    ft = { "markdown" },
}
