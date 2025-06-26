-- PLUGIN 11: markdown-preview
return {
    'iamcco/markdown-preview.nvim',
    ft = 'markdown', -- Only load this plugin for markdown files
    build = 'cd app && npm install', -- Install Node.js dependencies
    init = function ()
        vim.g.mkdp_brower = 'google-chrome'
    end,
}
