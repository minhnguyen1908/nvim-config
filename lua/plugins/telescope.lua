-- PLUGIN 9: telescope.nvim - A highly extensible fuzzy finder.
-- Incredibly powerful for quickly finding files, text content, Git commits, and more.
return { 'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }, -- Plenary is a dependency for Telescope
    config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep (search content)' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'List Buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search Help' })
    end
}
