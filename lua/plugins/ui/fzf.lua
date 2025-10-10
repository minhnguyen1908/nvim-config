return {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        winopts = {
            height = 0.85,
            width = 0.85,
            preview = {
                layout = 'vertical',
                vertical = 'up:60%',
                wrap = false,
            },
        },
        files = {
            cmd = 'fd --type f',
        },
        live_grep = {
            cmd = 'rg --vimgrep --no-heading --line-number --color=always {query}',
        },
        previewer = {
            extensions = {
                ['.'] = 'bat',
            },
            bat = {
                theme = 'ansi-dark',
                args = { '--style=header,grid', '--color=always' },
            },
        },
        git = {
            diff_tool = 'delta',
        },
    },
}

